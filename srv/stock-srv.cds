using app.stocktransfer from '../db/stocktransfer';
using {sap} from '@sap/cds-common-content';

service StockService {

    // Enabling draft for managing stock transfers
    @odata.draft.enabled: true
    entity StockTransfers as projection on stocktransfer.StockTransfers;

    // Exposing Bins entity for bin management
    entity Bins as projection on stocktransfer.Bins;

    // Exposing Products entity for product management
    entity Products as projection on stocktransfer.Products;

    // Exposing Status entity for managing transfer statuses
    entity Status as projection on stocktransfer.Status;

    // Optional: Expose BinStock for stock levels
    entity BinStock as projection on stocktransfer.BinStock;

    // Optional: Languages for value help or localization
    @readonly
    entity Languages as projection on sap.common.Languages;

    // Actions for managing stock transfers
    action addStockTransfer(
        productID: String(5),
        sourceBinID: String(5),
        destinationBinID: String(5),
        quantity: Integer,
        comment: String(500),
        statusID: String(10) // Include statusID
    ) returns String;

    action deleteStockTransfer(
        transferID: String(5)
    ) returns String;

    action modifyStockTransfer(
        transferID: String(5),
        quantity: Integer,
        comment: String(500),
        statusID: String(10) // Allow modifying the status
    ) returns String;
}
