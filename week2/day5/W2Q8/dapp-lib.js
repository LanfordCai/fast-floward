'use strict';
const Blockchain = require( './blockchain');
const dappConfig = require( './dapp-config.json');
const ClipboardJS = require( 'clipboard');
const BN = require('bn.js'); // Required for injected code
const manifest = require('../manifest.json');
const t = require('@onflow/types');


module.exports = class DappLib {

  // kittyItemsBatchMintKittyItem
  // calls transactions/kittyitems/batch_mint_kitty_item.cdc
  // 
  // signer/proposer/authorizer: config.accounts[0]
  //
  // Note: batch_mint_kitty_item.cdc takes in 2 parameters:
  // 1) recipients
  // 2) typeIDs
  // 
  // Note #2: the proposer is always `config.accounts[0]`
  // because that is the only account with the NFTMinter Resource
  //
  static async kittyItemsBatchMintKittyItem(data) {
    let config = DappLib.getConfig()
    let typeIDs = [data.typeID1, data.typeID2, data.typeID3].map(t => parseInt(t))
    let result = await Blockchain.post({
      config: config,
      roles: {
        proposer: config.accounts[0]
      }
    },
      'kittyitems_batch_mint_kitty_item',
      {
        recipients: {value: data.recipient, type: t.Address},
        typeIDs: {value: typeIDs, type: t.Array(t.UInt64)}
      }
    );

    return {
      type: DappLib.DAPP_RESULT_TX_HASH,
      label: 'Transaction Hash',
      result: result.callData.transactionId
    }
  }
}