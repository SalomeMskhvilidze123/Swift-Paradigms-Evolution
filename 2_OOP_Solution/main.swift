// ფაილი: 2_OOP_Solution/main.swift
// პრობლემების გადაჭრა OOP პრინციპებით

enum AccountStatus {
    case active, frozen, closed
}

class UserAccount {
    public let ownerName: String
    private var balance: Double // მონაცემი დამალულია!
    private var status: AccountStatus // მონაცემი დამალულია!

    init(ownerName: String, initialBalance: Double) {
        self.ownerName = ownerName
        self.balance = initialBalance
        self.status = .active
    }

    // საჯარო მეთოდები, რომლებიც მონაცემებთან კონტროლირებად წვდომას უზრუნველყოფენ
    public func deposit(amount: Double) {
        guard status != .closed else { return }
        if amount > 0 { self.balance += amount }
    }

    public func withdraw(amount: Double) {
        guard status == .active, balance >= amount else { return }
        self.balance -= amount
    }

    public func close() {
        if self.balance == 0 { self.status = .closed }
    }
    
    // ახალი ფუნქციონალი, დამატებული კლასის შიგნით
    public func applyAnnualInterest(interestRate: Double) {
        guard self.status == .active else { return } // წესი დაცულია!
        let interestAmount = self.balance * interestRate / 100.0
        self.balance += interestAmount
    }

    public func getBalance() -> Double { return self.balance }
}

// --- მთავარი პროგრამა: OOP ობიექტის გამოყენება ---
print("--- ანგარიშის შექმნა (OOP სტილით) ---")
let user1Account = UserAccount(ownerName: "სანდრო", initialBalance: 500.0)
print("ანგარიში შეიქმნა. ბალანსი: \(user1Account.getBalance())")

// პირდაპირი წვდომა შეუძლებელია! ეს ხაზი გამოიწვევს კომპილაციის შეცდომას.
// user1Account.balance = 1_000_000 // ERROR: 'balance' is inaccessible due to 'private' protection level

print("\n--- უსაფრთხო ოპერაციები მეთოდებით ---")
user1Account.withdraw(amount: 500.0)
user1Account.close()
user1Account.applyAnnualInterest(interestRate: 5.0) // არაფერი მოხდება, რადგან ანგარიში დახურულია
print("საბოლოო ბალანსი: \(user1Account.getBalance())") // ბალანსი კვლავ 0.0-ია
