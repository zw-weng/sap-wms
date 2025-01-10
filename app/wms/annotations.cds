using StockService as service from '../../srv/stock-srv';
annotate service.StockTransfers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'transferID',
                Value : transferID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'product_productID',
                Value : product_productID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'sourceBin_binID',
                Value : sourceBin_binID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'destinationBin_binID',
                Value : destinationBin_binID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'quantity',
                Value : quantity,
            },
            {
                $Type : 'UI.DataField',
                Label : 'transferDate',
                Value : transferDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'status_statusID',
                Value : status_statusID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'comment',
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
            Label : 'transferID',
            Value : transferID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'product_productID',
            Value : product_productID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'sourceBin_binID',
            Value : sourceBin_binID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'destinationBin_binID',
            Value : destinationBin_binID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'quantity',
            Value : quantity,
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
                LocalDataProperty : product_productID,
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
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'unitOfMeasure',
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
                LocalDataProperty : sourceBin_binID,
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
                LocalDataProperty : destinationBin_binID,
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
    status @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Status',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : status_statusID,
                ValueListProperty : 'statusID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'description',
            },
        ],
    }
};

