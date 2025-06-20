#[test_only]
module tomcrown::tomcrown_tests;

use tomcrown::tomcrown::{Self, TOMCROWN};
use sui::coin::{TreasuryCap};
use sui::test_scenario::{Self, next_tx, ctx};


#[test]
fun init_and_mint() {
    let addr1 = @0xA;

    let mut scenario = test_scenario::begin(addr1);

    {
        tomcrown::test_init(ctx(&mut scenario));
    };

    next_tx(&mut scenario, addr1);
    {
        let mut treasurycap = test_scenario::take_from_sender<TreasuryCap<TOMCROWN>>(&scenario);
        tomcrown::mint(&mut treasurycap, 1000000_00000000, addr1, ctx(&mut scenario));

        test_scenario::return_to_address<TreasuryCap<TOMCROWN>>(addr1, treasurycap);
    };

    
    test_scenario::end(scenario);
}