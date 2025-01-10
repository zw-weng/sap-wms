namespace app.stocktransfer;

// Define custom types
type BinID          : String(5);      // Format: B000X
type ProductID      : String(5);      // Format: P000X
type TransferID     : String(5);      // Format: T000X
type StatusID       : String(10);     // Primary Key for Status Entity
type Quantity       : Integer;
type Comment        : String(500);
type TDate          : DateTime;       // Timestamp for transferDate

// Entity: Status
entity Status {
    key statusID   : StatusID;        // Primary Key, e.g., Pending, Completed
    description    : String(50);      // Description for display purposes
}

// Entity: Bins
entity Bins {
    key binID     : BinID;            // Primary Key

    @UI.Identification: [{ position: 20 }]
    location  : String(50);

    @UI.LineItem: [{ position: 30 }]
    capacity  : Quantity;

    @UI.LineItem: [{ position: 40 }]
    binType   : String(20);           // e.g., Raw Materials, Finished Goods
}

// Entity: Products
entity Products {
    key productID   : ProductID;      // Primary Key

    @UI.LineItem: [{ position: 20 }]
    name        : String(100);

    @UI.LineItem: [{ position: 30 }]
    description : String(500);

    @UI.LineItem: [{ position: 40 }]
    category    : String(50);         // e.g., Electronics, Chemicals

    @UI.LineItem: [{ position: 50 }]
    unitOfMeasure: String(10);        // e.g., kg, pcs
}

// Entity: BinStock
entity BinStock {
    key bin       : Association to Bins;  // Composite Primary Key (bin + product)
    key product   : Association to Products;

    @UI.LineItem: [{ position: 10 }]
    quantity  : Quantity;

    @UI.LineItem: [{ position: 20 }]
    lastUpdated: TDate @UI.DataPoint: { type: #DateTime };
}

// Entity: StockTransfers
entity StockTransfers {
    key transferID   : TransferID;    // Primary Key

    product          : Association to Products;
    sourceBin        : Association to Bins;
    destinationBin   : Association to Bins;

    @UI.LineItem: [{ position: 20 }]
    quantity         : Quantity;

    @UI.LineItem: [{ position: 30 }]
    transferDate     : TDate @UI.DataPoint: { type: #DateTime };

    status           : Association to Status; // Association to Status entity

    @UI.LineItem: [{ position: 50 }]
    comment          : Comment;
}
