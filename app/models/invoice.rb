class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  scope :successful, -> {joins(:transactions).where('result = ?', 'success')}
  scope :failed, -> {joins(:transactions).where('result = ?', 'failed')}

  def self.random
    offset = rand(Invoice.count)
    Invoice.offset(offset).first
  end

  def revenue
    invoice_items.sum("quantity * unit_price")
  end
end
