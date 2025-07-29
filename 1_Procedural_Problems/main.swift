//მოდით დროში ვიმოგზაუროთ და შევხედოთ პრობლემას ისე როგორც მას 1980-იანი წლების ინჟინერი დაინახავდა.
//
//იმ დროს დომინანტი იყო სტრუქტურული პროგრამირების მიდგომა (მაგალითად, C ენაზე). ჩვენ Swift-ის სინტაქსს გამოვიყენებთ, მაგრამ ზუსტად იმ სტილს და ლოგიკას მივბაძავთ.
enum AccountStatus {
    case active, frozen, closed
}

// მომხმარებლის ანგარიშის მონაცემთა სტრუქტურა
struct UserAccount {
    let ownerName: String
    var balance: Double
    var status: AccountStatus
}

//  გლობალური ფუნქციები, რომლებიც მონაცემებისგან დაშორებულია

func deposit(into account: inout UserAccount, amount: Double) {
    guard account.status != .closed else {
        print("შეცდომა: ანგარიში დახურულია.")
        return
    }
    account.balance += amount
    print("\(amount) ლარი შეტანილია. ახალი ბალანსი: \(account.balance)")
}

func withdraw(from account: inout UserAccount, amount: Double) {
    guard account.status == .active else {
        print("შეცდომა: ანგარიში არააქტიურია.")
        return
    }
    guard account.balance >= amount else {
        print("შეცდომა: არასაკმარისი თანხა.")
        return
    }
    account.balance -= amount
    print("\(amount) ლარი გატანილია. ახალი ბალანსი: \(account.balance)")
}

func close(account: inout UserAccount) {
    if account.balance > 0 {
        print("გთხოვთ, ჯერ გაანულოთ ბალანსი.")
        return
    }
    account.status = .closed
    print("ანგარიში წარმატებით დაიხურა.")
}

//  წამოიდგინეტ ახალი დეველოპერის დაწერილი პრობლემური ფუნქცია, სადაც ადმიაური შეცდომის სისტემური გადაზღევავ არ ხდება და ლოკალურად ხდება შემოწმების მართვა. რაც ჩავთვალთოტ რომ დეველოპერმა გამოტოვა ეს ნაბიჭი
func applyAnnualInterest(to account: inout UserAccount, interestRate: Double) {
    // პრობლემა: ეს ფუნქცია არ ამოწმებს ანგარიშის სტატუსს!
    let interestAmount = account.balance * interestRate / 100.0
    account.balance += interestAmount
    print("დაირიცხა \(interestAmount) ლარის სარგებელი.")
}


// --- მთავარი პროგრამა: პრობლემის დემონსტრაცია ---
print("ანგარიშის შექმნა")
var user1Account = UserAccount(ownerName: "სანდრო", balance: 500.0, status: .active)
print("ანგარიში შეიქმნა. ბალანსი: \(user1Account.balance)")

print("თანხის გატანა და დახურვა")
withdraw(from: &user1Account, amount: 500.0)
close(account: &user1Account)
print("ანგარიშის სტატუსი: \(user1Account.status)")

print("\ერთი წლის შემდეგ, ახალი დეველოპერის კოდი მუშაობს")
// დახურულ ანგარიშზე ხდება ოპერაცია, რაც კატასტროფაა!
applyAnnualInterest(to: &user1Account, interestRate: 5.0)
print("საბოლოო ბალანსი დახურულ ანგარიშზე: \(user1Account.balance)")

print("კიდევ ერთი პრობლემა: პირდაპირი, დაუცველი წვდომა")
user1Account.balance = 1000000
print("ბალანსი პირდაპირი ჩარევით გახდა: \(user1Account.balance)")
