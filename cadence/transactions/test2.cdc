import BadBot
import Example

transaction() {
    let allowance: @BadBot.Allowance?
    
    prepare(signer: AuthAccount) {
        allowance <- signer.load<@BadBot.Allowance>(from: BadBot.AllowanceStoragePath)
    }
    
    execute {
        Example.test2()
    }
}