using StockService as service from '../../srv/stock-srv';

annotate service.StockTransfers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Transfer ID',
                Value : transferID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Product ID',
                Value : product_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Source Bin ID',
                Value : sourceBin_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Destination Bin ID',
                Value : destinationBin_ID,
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
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Transfer ID',
            Value : transferID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Product ID',
            Value : product_ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Source Bin ID',
            Value : sourceBin_ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Destination Bin ID',
            Value : destinationBin_ID,
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
);

annotate service.StockTransfers with {
    product @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Products',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : product_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'productID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'description',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'category',
            },
        ],
    }
};

annotate service.StockTransfers with {
    sourceBin @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Bins',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : sourceBin_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'binID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'location',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'capacity',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'binType',
            },
        ],
    }
};

annotate service.StockTransfers with {
    destinationBin @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Bins',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : destinationBin_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'binID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'location',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'capacity',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'binType',
            },
        ],
    }
};
