using StockService as service from '../../srv/stock-srv';

annotate service.StockTransfers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Transfer ID',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Product ID',
                Value : product_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Source Bin ID',
                Value : sourceBinStock.bin_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Destination Bin ID',
                Value : destinationBinStock_bin_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Quantity',
                Value : quantity,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Transfer Date',
                Value : transferDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Status',
                Value : status,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Comment',
                Value : comment,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneralInfo',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Transfer ID',
            Value : ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Product ID',
            Value : product_ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Source Bin ID',
            Value : sourceBinStock.bin_ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Destination Bin ID',
            Value : destinationBinStock_bin_ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Quantity',
            Value : quantity,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Transfer Date',
            Value : transferDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Comment',
            Value : comment,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Create Stock Transfer',
            Action : 'StockService.transferStock'
        }
    ],
    UI.HeaderInfo : {
        TypeName : 'Stock Transfer',
        TypeNamePlural : 'Stock Transfers',
        Title : {
            $Type : 'UI.DataField',
            Value : ID, // Header Title will use Transfer ID
        }
    }
);

