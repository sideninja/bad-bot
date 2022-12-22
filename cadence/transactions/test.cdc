import BadBot
import Example

transaction() {
    var allowance: &BadBot.Allowance
    
    prepare(signer: AuthAccount) {
        self.allowance = signer.getCapability<&BadBot.Allowance>(BadBot.AllowancePublicPath).borrow() ?? panic("don't have allowance")
    }

    execute {
        Example.test(allowance: self.allowance)
    }
}