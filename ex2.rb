class BankAccount
    @@interest_rate = 0.02
    @@accounts = []

    def self.create
        account = BankAccount.new
        @@accounts.push(account)
        return account
    end

    def self.total_funds
        funds = 0
        @@accounts.each do |account|
            funds += account.balance
        end
        return funds
    end

    def self.interest_time
        for account in @@accounts
            balance_plus_interest = account.balance * (1 + @@interest_rate)
            account.balance=(balance_plus_interest)
        end
    end

    def initialize
        @balance = 0

    end

    def balance
        return @balance
    end

    def balance=(new_balance)
        @balance = new_balance
    end

    def deposit(value)
        @balance += value
    end

    def withdraw(value)
        @balance -= value
    end

end
my_account = BankAccount.create
your_account = BankAccount.create
puts my_account.balance # 0
puts BankAccount.total_funds # 0
my_account.deposit(200)
your_account.deposit(1000)
puts my_account.balance # 200
puts your_account.balance # 1000
puts BankAccount.total_funds # 1200
BankAccount.interest_time
puts my_account.balance # 202.0
puts your_account.balance # 1010.0
puts BankAccount.total_funds # 1212.0
my_account.withdraw(50)
puts my_account.balance # 152.0
puts BankAccount.total_funds # 1162.0