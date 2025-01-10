const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { StockTransfers } = this.entities;

    // Validate data before creating a Stock Transfer
    this.before('CREATE', 'StockTransfers', async (req) => {
        const { sourceBin_binID, destinationBin_binID, quantity } = req.data;

        // Rule 1: Source and Destination Bin cannot be the same
        if (sourceBin_binID === destinationBin_binID) {
            return req.error(400, `Source bin and destination bin cannot be the same.`);
        }

        // Rule 2: Quantity must be greater than 0
        if (quantity <= 0) {
            return req.error(400, `Quantity must be greater than zero.`);
        }

        // Optional Rule 3: Validate sourceBin has sufficient quantity
        // Check the BinStock table to validate stock levels
        const binStock = await cds.transaction(req).run(
            SELECT.one.from('stocktransfer.BinStock')
                .where({ bin_binID: sourceBin_binID, product_productID: req.data.product_productID })
        );
        if (!binStock || binStock.quantity < quantity) {
            return req.error(400, `Insufficient stock in the source bin.`);
        }
    });

    // Optional: Add similar validation for UPDATE if needed
    this.before('UPDATE', 'StockTransfers', async (req) => {
        const { sourceBin_binID, destinationBin_binID, quantity } = req.data;

        // Rule 1: Source and Destination Bin cannot be the same
        if (sourceBin_binID === destinationBin_binID) {
            return req.error(400, `Source bin and destination bin cannot be the same.`);
        }

        // Rule 2: Quantity must be greater than 0
        if (quantity <= 0) {
            return req.error(400, `Quantity must be greater than zero.`);
        }
    });
});
