class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_initialize :set_default_role, :if => :new_record?

  enum :role, { regular: 0, admin: 5 }
  validates :name, :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :is_valid_cpf?

  private

  def set_default_role
    if self.email.split('@')[1] == "leilaodogalpao.com.br"
      self.role = :admin
      return
    end
    self.role = :regular
  end

  def is_valid_cpf?
    def valid_cpf?(cpf)
      deny_list = %w[
          00000000000
          11111111111
          22222222222
          33333333333
          44444444444
          55555555555
          66666666666
          77777777777
          88888888888
          99999999999
          12345678909
          01234567890
      ]

      cpf_numbers = cpf.delete('^0-9').chars.map(&:to_i)
      return false unless cpf_numbers.size == 11
      return false if deny_list.include?(cpf_numbers.join)

      valid_first_digit?(cpf_numbers) && valid_second_digit?(cpf_numbers)
    end

    def valid_first_digit?(cpf)
      multiplied = cpf[0..8].map.with_index { |number, index| number * (10 - index) }

      verifier_digit(multiplied) == cpf[9]
    end

    def valid_second_digit?(cpf)
      multiplied = cpf[0..9].map.with_index { |number, index| number * (11 - index) }

      verifier_digit(multiplied) == cpf[10]
    end

    def verifier_digit(multiplied)
      rest = multiplied.sum % 11
      rest < 2 ? 0 : 11 - rest
    end

    return if self.cpf.nil?

    result = valid_cpf?(self.cpf)
    unless result
       self.errors.add(:cpf, 'invalido')
    end
  end
end
