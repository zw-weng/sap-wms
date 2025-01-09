const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { StockTransfers, BinStock } = this.entities;

    // Add Stock Transfer Action
    this.on('addStockTransfer', async (req) => {
        const { productID, sourceBinID, destinationBinID, quantity, comment } = req.data;

        // Validate input
        if (!productID || !sourceBinID || !destinationBinID || quantity <= 0) {
            return req.error(400, 'Invalid input parameters.');
        }

        // Check if sufficient stock is available in the source bin
        const sourceBinStock = await SELECT.one.from(BinStock)
            .where({ bin_ID: sourceBinID, product_ID: productID });

        if (!sourceBinStock || sourceBinStock.quantity < quantity) {
            return req.error(400, 'Insufficient stock in the source bin.');
        }

        // Generate a unique ID for the stock transfer
        const transferID = `TRANS${Date.now()}`;
        const transferDate = new Date().toISOString();

        // Update stock in the source bin
        await UPDATE(BinStock)
            .set({ quantity: sourceBinStock.quantity - quantity })
            .where({ bin_ID: sourceBinID, product_ID: productID });

        // Update or create stock in the destination bin
        const destinationBinStock = await SELECT.one.from(BinStock)
            .where({ bin_ID: destinationBinID, product_ID: productID });

        if (destinationBinStock) {
            await UPDATE(BinStock)
                .set({ quantity: destinationBinStock.quantity + quantity })
                .where({ bin_ID: destinationBinID, product_ID: productID });
        } else {
            await INSERT.into(BinStock).entries({
                bin_ID: destinationBinID,
                product_ID: productID,
                quantity,
            });
        }

        // Insert a new stock transfer record
        await INSERT.into(StockTransfers).entries({
            ID: transferID,
            product_ID: productID,
            sourceBinStock_bin_ID: sourceBinID,
            destinationBinStock_bin_ID: destinationBinID,
            quantity,
            transferDate,
            status: 'Pending',
            comment,
        });

        return `Stock transfer added successfully with ID: ${transferID}`;
    });

    // Delete Stock Transfer Action
    this.on('deleteStockTransfer', async (req) => {
        const { ID } = req.data;
        await DELETE.from(StockTransfers).where({ ID });
        return `Stock transfer with ID ${ID} deleted successfully.`;
    });

    // Modify Stock Transfer Action
    this.on('modifyStockTransfer', async (req) => {
        const { transferID, quantity, comment } = req.data;
        await UPDATE(StockTransfers)
            .set({ quantity, comment })
            .where({ ID: transferID });
        return `Stock transfer with ID ${transferID} updated successfully.`;
    });
});
