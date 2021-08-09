
it(`mints 3 kittyitems into account in batch and has correct collection information`, async () => {
    let testData1 = {
        recipient: config.accounts[0],
        typeID1: "100",
        typeID2: "101",
        typeID3: "102"
    }

    let testData2 = {
        address: config.accounts[0]
    }

    await DappLib.kittyItemsBatchMintKittyItem(testData1)

    let res1 = await DappLib.kittyItemsReadCollectionIDs(testData2)
    let res2 = await DappLib.kittyItemsReadCollectionLength(testData2)

    assert.deepEqual(res1.result, [1, 2, 3, 4], "Incorrect ID in KittyItems collection")
    assert.equal(res2.result, 4, "Incorrect length of KittyItems collection")
})