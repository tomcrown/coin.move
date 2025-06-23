module airdrop::mass_send;

use sui::coin::{Self, Coin};
use sui::event;


const E_LENGTH_MISMATCH: u64 = 0;


public struct AirdropEvent has copy, drop {
    amount: u64,
    recipient: address,
}


public entry fun send_by_allocation<T: store>(
    coin: &mut Coin<T>,
    recipients: vector<address>,
    amounts: vector<u64>,
    ctx: &mut TxContext
) {
    let num_recipients = vector::length(&recipients);
    let num_amounts = vector::length(&amounts);

    assert!(num_recipients == num_amounts, E_LENGTH_MISMATCH);

    let mut i = 0;
    while (i < num_recipients) {
        let amount = *vector::borrow(&amounts, i);
        let recipient = *vector::borrow(&recipients, i);
        let portion = coin::split(coin, amount, ctx);
        transfer::public_transfer(portion, recipient);

        event::emit(AirdropEvent {
            amount,
            recipient,
    });

        i = i + 1;
    };
}





