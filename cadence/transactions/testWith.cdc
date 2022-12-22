import BadBot
import Example

transaction() {
    let acc: AuthAccount

    prepare(signer: AuthAccount) {
        self.acc = signer
    }

    execute {
        let allowance = self.acc.getCapability(BadBot.AllowancePublicPath).borrow<&BadBot.Allowance>() ?? panic("don't have allowance")
        Example.test(allowance: allowance)
    }
}