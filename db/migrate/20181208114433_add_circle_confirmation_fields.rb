class AddCircleConfirmationFields < ActiveRecord::Migration[4.2]
  def change
    add_column :usuarios, :confirmed_circle_at, :datetime, after: :unconfirmed_email
    add_column :usuarios, :confirmation_token_circle, :string, after: :confirmed_circle_at
    add_column :usuarios, :confirmation_circle_sent_at, :datetime, after: :confirmation_token_circle
    add_column :usuarios, :unconfirmed_circle, :string, after: :confirmation_circle_sent_at # Only if using reconfirmable
    add_index :usuarios, :confirmation_token_circle, unique: true
    if Rails.env.production?
      execute("UPDATE usuarios SET confirmed_circle_at = NOW()") if Rails.env.production?
    else
      execute("UPDATE usuarios SET confirmed_circle_at = date(NOW())")
    end

  end
end
