namespace my.wms;

using { cuid, managed } from '@sap/cds/common';

entity Bins : managed {
  key ID           : UUID;          // Unique identifier for the bin
  location         : String(50);    // Physical location of the bin
  capacity         : Integer;       // Maximum capacity of the bin
  binType          : String(20);    // Type of the bin (e.g., Raw Materials, Finished Goods, Packing)
}

entity Products : managed {
  key ID               : UUID;         // Unique identifier for the product
  name                 : String(100);  // Name of the product
  description          : String(500);  // Description of the product
  productCategory      : String(50);   // Category of the product (e.g., Electronics, Chemicals)
  unitOfMeasure        : String(10);   // Unit of measure for the product (e.g., kg, pcs)
}

entity BinStock : managed {
  key bin        : Association to Bins;        // Bin holding the stock
  key product    : Association to Products;    // Product stored in the bin
  quantity       : Integer;                    // Quantity of the product in the bin
  lastUpdated    : DateTime;                   // Timestamp when stock was last updated
}

entity StockTransfers : managed {
  key ID               : UUID;                   // Unique identifier for the stock transfer
  product              : Association to Products;// Product being transferred
  sourceBinStock       : Association to BinStock;// Source bin-product record
  destinationBinStock  : Association to BinStock;// Destination bin-product record
  quantity             : Integer;                // Quantity being transferred
  transferDate         : DateTime;               // Timestamp of the transfer
  status               : String(20) enum {       // Status of the transfer
                        Pending;
                        Completed;
                        Failed;
                        InTransit;
                      };
  comment              : String(500);            // Optional comment for the transfer
}
