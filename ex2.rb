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
            account.balance = (balance_plus_interest)
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
# my_account = BankAccount.create
# your_account = BankAccount.create
# puts my_account.balance # 0
# puts BankAccount.total_funds # 0
# my_account.deposit(200)
# your_account.deposit(1000)
# puts my_account.balance # 200
# puts your_account.balance # 1000
# puts BankAccount.total_funds # 1200
# BankAccount.interest_time
# puts my_account.balance # 202.0
# puts your_account.balance # 1010.0
# puts BankAccount.total_funds # 1212.0
# my_account.withdraw(50)
# puts my_account.balance # 152.0
# puts BankAccount.total_funds # 1162.0


# ------------------------------------------


class Book 

    @@on_shelf = []
    @@on_loan = []

    def self.create(title, author, isbn)
        book = Book.new(title, author, isbn)
        @@on_shelf << book
        return book
    end

    def self.current_due_date
    end

    def self.overdue_books
        return @@on_loan.select {|book| book.due_date < Time.now }
    end

    def self.browse
        return @@on_shelf.sample
    end

    def self.available
        return @@on_shelf
    end

    def self.borrowed
        return @@on_loan
    end


# Instance Methods

    def initialize(title, author, isbn)
        @due_date = Time.now + 604800
        @title = title
        @author = author
        @isbn = isbn
    end

    def due_date
        return @due_date
    end

    def borrow
        if self.lent_out?
            return false
        else
            @due_date = Time.now + 604800
            @@on_shelf.delete(self) 
            @@on_loan << self
            return true
        end
    end

    def return_to_library
        if !self.lent_out?
            return false
        else
            @due_date = nil
            @@on_shelf << self
            @@on_loan.delete(self) 
            return true
        end
    end

    def lent_out?
        return Book.borrowed.include?(self)
    end
end


# sister_outsider = Book.create("Sister Outsider", "Audre Lorde", "9781515905431")
# aint_i = Book.create("Ain't I a Woman?", "Bell Hooks", "9780896081307")
# if_they_come = Book.create("If They Come in the Morning", "Angela Y. Davis", "0893880221")
# puts Book.browse.inspect # #<Book:0x00555e82acdab0 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221"> (this value may be different for you)
# puts Book.browse.inspect # #<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307"> (this value may be different for you)
# puts Book.browse.inspect # #<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307"> (this value may be different for you)
# puts Book.available.inspect # [#<Book:0x00555e82acde20 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431">, #<Book:0x00555e82acdce0 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00555e82acdab0 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">]
# puts Book.borrowed.inspect # []
# puts sister_outsider.lent_out? # false
# puts sister_outsider.borrow # true
# puts sister_outsider.lent_out? # true
# puts sister_outsider.borrow # false
# puts sister_outsider.due_date # 2017-02-25 20:52:20 -0500 (this value will be different for you)
# puts Book.available.inspect # [#<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00562314675fd8 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">]
# puts Book.borrowed.inspect # [#<Book:0x00562314676208 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431", @due_date=2017-02-25 20:55:17 -0500>]
# puts Book.overdue_books.inspect # []
# puts sister_outsider.return_to_library # true
# puts sister_outsider.lent_out? # false
# puts Book.available.inspect # [#<Book:0x00562314676118 @title="Ain't I a Woman?", @author="Bell Hooks", @isbn="9780896081307">, #<Book:0x00562314675fd8 @title="If They Come in the Morning", @author="Angela Y. Davis", @isbn="0893880221">, #<Book:0x00562314676208 @title="Sister Outsider", @author="Audre Lorde", @isbn="9781515905431", @due_date=nil>]
# puts Book.borrowed.inspect # []

# ------------------------------------------

class Zombie

    @@horde = []
    @@plague_level = 10
    @@max_speed = 5 
    @@max_strength = 8 
    @@default_speed = 1
    @@default_strength = 3

    def self.all
        return @@horde
    end

    def self.new_day
        self.some_die_off
        self.spawn
        self.increase_plague_level
    end

    def self.some_die_off
        rand(11).times do
            @@horde.pop
        end
    end

    def self.spawn
        new_zombies = rand(@@plague_level + 1)
        new_zombies.times do
            @@horde << Zombie.new(rand(@@max_speed + 1), rand(@@max_strength + 1))
        end
    end

    def self.increase_plague_level
        @@plague_level += rand(@@horde.length) / 3
    end

    def self.deadliest_zombie
        return @@horde
    end

    # instance methods

    def initialize(speed, strength)
        @speed = speed
        @strength = strength
        if @speed > @@max_speed
            @speed = @@default_speed
        end
        if @strength > @@max_strength
            @strength = @@default_strength
        end
    end

    def outrun_zombie?
        my_speed = rand(@@max_speed +1)
        return my_speed > @speed
    end
    
    def survive_attack?
        my_strength = rand(@@max_strength +1)
        return my_strength > @strength
    end

    def encounter
        if outrun_zombie?
            return "You ourtan the zombie!"
        elsif !survive_attack?
            return "You died."
        else
            @@horde.push(Zombie.new(rand(@@max_speed + 1), rand(@@max_strength + 1)))
            return "You caught the zombie plague and are now a zombie."
        end
    end
end

# puts Zombie.all.inspect # []
# Zombie.new_day
# puts Zombie.all.inspect # [#<Zombie:0x005626ecc5ebd0 @speed=4, @strength=0>, #<Zombie:0x005626ecc5eba8 @speed=0, @strength=4>, #<Zombie:0x005626ecc5eb80 @speed=4, @strength=4>]
# zombie1 = Zombie.all[0]
# zombie2 = Zombie.all[1]
# zombie3 = Zombie.all[2]
# puts zombie1.encounter # You are now a zombie
# puts zombie2.encounter # You died
# puts zombie3.encounter # You died
# Zombie.new_day
# puts Zombie.all.inspect # [#<Zombie:0x005626ecc5e1f8 @speed=0, @strength=0>, #<Zombie:0x005626ecc5e180 @speed=3, @strength=3>, #<Zombie:0x005626ecc5e158 @speed=1, @strength=2>, #<Zombie:0x005626ecc5e090 @speed=0, @strength=4>]
# zombie1 = Zombie.all[0]
# zombie2 = Zombie.all[1]
# zombie3 = Zombie.all[2]
# puts zombie1.encounter # You got away
# puts zombie2.encounter # You are now a zombie
# puts zombie3.encounter # You died

# ------------------------------------------

class Vampire

    @@coven = []

    def self.coven
        return @@coven
    end


    def self.create(name, age)
        vampire = Vampire.new(name, age)
        @@coven.push(vampire)
        return vampire
    end

    def self.sunrise
        counter = 0
        while counter < @@coven.length
            if (@@coven[counter].drank_blood_today == false)
                @@coven.delete_at(counter)
            end
            if (@@coven[counter].in_coffin == false)
                @@coven.delete_at(counter)
            end
            counter += 1
        end
        return @@coven
    end

    def self.sunset
        for vampire in @@coven
            vampire.drank_blood_today = false
            vampire.in_coffin = false
        end
    end

# instance variables

    def initialize(name, age)
        @name = name
        @age = age
        @in_coffin = true
        @drank_blood_today = false
    end

#read

    def name
        return @name
    end

    def age
        return @age
    end

    def in_coffin
        return @in_coffin
    end

    def drank_blood_today
        return @drank_blood_today
    end

# write

    def in_coffin=(bool)
        @in_coffin = bool
    end

    def drank_blood_today=(bool)
        @drank_blood_today = bool
    end

    def drink_blood
        @drank_blood_today = true
    end

    def go_home
        @in_coffin = true
    end
end

carmilla = Vampire.create("Carmilla", 24)
vlad = Vampire.create("Vlad", 40)
dracula = Vampire.create("Dracula", 59)
puts "Coven: #{Vampire.coven.inspect}"
puts "\n"

Vampire.sunset

puts "#{carmilla.name}, #{carmilla.age}, #{carmilla.in_coffin}, #{carmilla.drank_blood_today}"
puts "#{dracula.name}, #{dracula.age}, #{dracula.in_coffin}, #{dracula.drank_blood_today}"

carmilla.drink_blood
carmilla.go_home
dracula.drink_blood
vlad.go_home
puts "\n"

puts "--- vampires at sunrise:"
puts "#{carmilla.name}, #{carmilla.age}, #{carmilla.in_coffin}, #{carmilla.drank_blood_today}"
puts "#{dracula.name}, #{dracula.age}, #{dracula.in_coffin}, #{dracula.drank_blood_today}"
puts "\n"


Vampire.sunrise
puts "Vampires who survived the day: #{Vampire.coven.inspect}"

