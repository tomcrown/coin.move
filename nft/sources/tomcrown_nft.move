module nft::tomcrown_nft;

use std::string::{Self, String}; 
use sui::url::{Self, Url}; 
use sui::event;
use sui::balance::{Self, Balance}; 
use sui::coin::{Self, Coin}; 

public struct TOMCROWN_NFT<phantom T> has key, store {
    id: UID,
    name: String,
    description: String,
    url: Url,
    rarity: u8,
    balance: Balance<T>
}


public struct NFTMinted has copy, drop {
    rarity: u8,
    nft_name: String,
    description: String,
    url: Url
}


fun init(otw: TOMCROWN_NFT, ctx: &mut TxContext) {
    let keys = vector[
        utf8(b"name"),
        utf8(b"description"),
        utf8(b"image_url"),
        utf8(b"rarity")
    ];


    let values = vector[
        utf8(b"name"),
        utf8(b"description"),
        utf8(b"image_url"),
        utf8(b"rarity"),
    ];


    let publisher = package::claim(otw, ctx);

    let mut display = display::new_with_fields<TOMCROWN_NFT<SUI>> ()
}