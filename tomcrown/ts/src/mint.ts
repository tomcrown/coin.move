import { getFullnodeUrl, SuiClient } from '@mysten/sui.js/client';
import { TransactionBlock } from '@mysten/sui.js/transactions';
import { Ed25519Keypair } from '@mysten/sui.js/keypairs/ed25519';
import { decodeSuiPrivateKey } from '@mysten/sui.js/cryptography';


const client = new SuiClient({ url: getFullnodeUrl('devnet') });

const { secretKey } = decodeSuiPrivateKey('private-key')
const keypair = Ed25519Keypair.fromSecretKey(secretKey);
const PACKAGE_ID = '0x01a4916393573e9f3e89ca6f8a0a391087386a23b117370219ee7eb9ee1a000c';
const MODULE_NAME = 'tomcrown';
const STRUCT_NAME = 'TOMCROWN';
const TREASURY_CAP_ID = '0xbb36632379b68dc77504df98977feafe5a7c9a8ba60e017694d3eb1d8b09d34f';
const RECEPIENT_ADDRESS = 'address';


async function main() {
    const tx = new TransactionBlock();
    tx.moveCall({
        target: `${PACKAGE_ID}::${MODULE_NAME}::mint`,
        arguments: [
            tx.object(TREASURY_CAP_ID),
            tx.pure('100000000000000'),
            tx.pure(RECEPIENT_ADDRESS, "address"),
        ],
    });

    const result = await client.signAndExecuteTransactionBlock({
        transactionBlock: tx,
        signer: keypair,
    });

    console.log('Mint Result:', result);
}

main().catch(console.error)