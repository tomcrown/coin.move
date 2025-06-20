module tomcrown::tomcrown;


use sui::coin::{Self, TreasuryCap};


public struct TOMCROWN has drop {}

 
fun init(witness: TOMCROWN, ctx: &mut TxContext) {
    let multiplier = 100000000;
    let (mut treasury, metadata) = coin::create_currency(
        witness,
        8,
        b"TMS",
        b"Tomcrown",
        b"Tomcrown on Sui",
        option::none(),
        ctx
    );

    let initial_coins = coin::mint(&mut treasury, 300 * multiplier, ctx);
    transfer::public_transfer(initial_coins, tx_context::sender(ctx));

    transfer::public_freeze_object(metadata);
    transfer::public_transfer(treasury, tx_context::sender(ctx));

}

#[test_only]
public fun test_init(ctx: &mut TxContext) {
    init(TOMCROWN {},  ctx);
}


public fun mint(
    treasury_cap: &mut TreasuryCap<TOMCROWN>,
    amount: u64,
    recipient: address,
    ctx: &mut TxContext
) {
    let coin = coin::mint(treasury_cap, amount, ctx);
    transfer::public_transfer(coin, recipient);
}

