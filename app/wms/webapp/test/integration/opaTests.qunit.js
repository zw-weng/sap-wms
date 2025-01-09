sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'wms/test/integration/FirstJourney',
		'wms/test/integration/pages/StockTransfersList',
		'wms/test/integration/pages/StockTransfersObjectPage'
    ],
    function(JourneyRunner, opaJourney, StockTransfersList, StockTransfersObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('wms') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheStockTransfersList: StockTransfersList,
					onTheStockTransfersObjectPage: StockTransfersObjectPage
                }
            },
            opaJourney.run
        );
    }
);