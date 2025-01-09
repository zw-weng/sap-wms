const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
  const { StockTransfers, BinStock } = this.entities;

  this.on('transferStock', async (req) => {
    const { productID, sourceBinID, destinationBinID, quantity, comment } = req.data;

    if (!productID || !sourceBinID || !destinationBinID || !quantity || quantity <= 0) {
      return req.error(400, 'Invalid input parameters.');
    }

    if (sourceBinID === destinationBinID) {
      return req.error(400, 'Source and destination bins cannot be the same.');
    }

    const sourceStock = await SELECT.one.from(BinStock).where({ bin_ID: sourceBinID, product_ID: productID });
    if (!sourceStock || sourceStock.quantity < quantity) {
      return req.error(400, 'Insufficient stock in source bin.');
    }

    const destinationStock = await SELECT.one.from(BinStock).where({ bin_ID: destinationBinID, product_ID: productID });
    const newDestinationQuantity = destinationStock ? destinationStock.quantity + quantity : quantity;

    await UPDATE(BinStock).set({ quantity: { '-=': quantity } }).where({ bin_ID: sourceBinID, product_ID: productID });
    if (destinationStock) {
      await UPDATE(BinStock).set({ quantity: { '+=': quantity } }).where({ bin_ID: destinationBinID, product_ID: productID });
    } else {
      await INSERT.into(BinStock).entries({
        bin_ID: destinationBinID,
        product_ID: productID,
        quantity: newDestinationQuantity
      });
    }

    const transferID = cds.utils.uuid();
    await INSERT.into(StockTransfers).entries({
      ID: transferID,
      product_ID: productID,
      sourceBinStock_ID: sourceBinID,
      destinationBinStock_ID: destinationBinID,
      quantity,
      transferDate: new Date().toISOString(),
      status: 'Completed',
      comment
    });

    return `Stock transfer completed successfully. Transfer ID: ${transferID}`;
  });
});
