const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
  const { Bins, BinStock, Products, StockTransfers } = this.entities;

  /**
   * Handles the transferStock action.
   */
  this.on('transferStock', async (req) => {
    const { productID, sourceBinID, destinationBinID, quantity, comment } = req.data;

    // Validate input parameters
    if (!productID || !sourceBinID || !destinationBinID || !quantity || quantity <= 0) {
      return req.error(400, 'Invalid input parameters. Please check your request.');
    }

    // Validate source bin stock
    const sourceBinStock = await SELECT.one.from(BinStock)
      .where({ bin_ID: sourceBinID, product_ID: productID });

    if (!sourceBinStock || sourceBinStock.quantity < quantity) {
      return req.error(400, 'Insufficient stock in the source bin.');
    }

    // Validate destination bin
    const destinationBin = await SELECT.one.from(Bins).where({ ID: destinationBinID });
    if (!destinationBin) {
      return req.error(404, 'Destination bin not found.');
    }

    // Validate destination bin capacity
    const destinationBinStock = await SELECT.one.from(BinStock)
      .where({ bin_ID: destinationBinID, product_ID: productID });

    const destinationStock = destinationBinStock ? destinationBinStock.quantity : 0;
    const availableCapacity = destinationBin.capacity - destinationStock;

    if (quantity > availableCapacity) {
      return req.error(400, 'Destination bin does not have enough capacity.');
    }

    // Begin stock transfer
    const transferID = cds.utils.uuid();

    await INSERT.into(StockTransfers).entries({
      ID: transferID,
      product_ID: productID,
      sourceBinStock_ID: sourceBinStock.ID,
      destinationBinStock_ID: destinationBinStock?.ID || cds.utils.uuid(),
      quantity: quantity,
      transferDate: new Date().toISOString(),
      status: 'Pending',
      comment: comment || '', // Optional comment
    });

    try {
      // Update source bin stock
      await UPDATE(BinStock)
        .set({ quantity: { '-=': quantity }, lastUpdated: new Date().toISOString() })
        .where({ bin_ID: sourceBinID, product_ID: productID });

      // Update destination bin stock
      if (destinationBinStock) {
        await UPDATE(BinStock)
          .set({ quantity: { '+=': quantity }, lastUpdated: new Date().toISOString() })
          .where({ bin_ID: destinationBinID, product_ID: productID });
      } else {
        await INSERT.into(BinStock).entries({
          bin_ID: destinationBinID,
          product_ID: productID,
          quantity: quantity,
          lastUpdated: new Date().toISOString(),
        });
      }

      // Mark transfer as completed
      await UPDATE(StockTransfers)
        .set({ status: 'Completed' })
        .where({ ID: transferID });

      return `Stock transfer completed successfully. Transfer ID: ${transferID}`;
    } catch (error) {
      // Rollback the transfer if an error occurs
      await UPDATE(StockTransfers)
        .set({ status: 'Failed' })
        .where({ ID: transferID });

      console.error('Error during stock transfer:', error);
      return req.error(500, 'Stock transfer failed due to a system error.');
    }
  });
});
