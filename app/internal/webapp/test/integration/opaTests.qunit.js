sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'internal/test/integration/FirstJourney',
		'internal/test/integration/pages/StockTransfersList',
		'internal/test/integration/pages/StockTransfersObjectPage'
    ],
    function(JourneyRunner, opaJourney, StockTransfersList, StockTransfersObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('internal') + '/index.html'
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