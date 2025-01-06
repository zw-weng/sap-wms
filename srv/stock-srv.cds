using my.wms as wms from '../db/schema';
using {sap} from '@sap/cds-common-content';

service StockService {
    entity Bins           as projection on wms.Bins;
    entity Products       as projection on wms.Products;
    entity BinStock       as projection on wms.BinStock;
    entity StockTransfers as projection on wms.StockTransfers;

    action transferStock(
        productID: UUID,           // Product being transferred
        sourceBinID: UUID,         // Source bin ID
        destinationBinID: UUID,    // Destination bin ID
        quantity: Integer,         // Quantity to transfer
        comment: String            // Optional comment for the transfer
    ) returns String;
}
