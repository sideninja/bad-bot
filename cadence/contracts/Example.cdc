import BadBot

pub contract Example {

    pub fun test(allowance: &BadBot.Allowance) {
        if !allowance.valid() {
            log("NOT ALLOWED")
            panic("fail")
        }

        log("ALLOWED")
    }
 
}