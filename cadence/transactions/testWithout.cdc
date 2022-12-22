import Example
import BadBot

transaction() {
    prepare(signer: AuthAccount) {}

    execute {
        Example.test(allowance: nil)
    }
}