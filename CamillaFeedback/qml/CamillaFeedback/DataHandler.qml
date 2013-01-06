import QtQuick 1.0

Item {
    id: dataHandler

//the region names should come from List_NameOfRegions.txt
//band names can be chosen freely

    property list<Band> bands: [
	/*
	Band{name: "Theta"; regionName: "Temporal_Lobe"; low: 4; high: 8;},
	Band{name: "Smr"; regionName: "Temporal_Lobe"; low: 12; high: 15; },
	Band{name: "Beta_Low"; regionName: "Temporal_Lobe"; low: 16; high: 18; },
	Band{name: "Theta"; regionName: "Frontal_Lobe"; low: 4; high: 8; },
	Band{name: "Smr"; regionName: "Frontal_Lobe"; low: 12; high: 15; },
	Band{name: "Beta_Low"; regionName: "Frontal_Lobe"; low: 16; high: 18; }
	*/

	Band{name: "Alpha"; regionName: "Occipital_Lobe"; low: 8; high: 12; }
    ]

    function dataReceived(data)
    {

	var dataString = String(data);

	var regions = dataString.split("&");
	//console.log(regions);

	if (regions.length == 3)
	{
	    var regionNames = regions[2];
	    regionNames = regionNames.split("@");
	    for (var i=0; i<regionNames.length; ++i)
	    {

		var name = regionNames[i];
		//console.log(name);
		var bands = regions[i];
		bands = bands.split("@")




		for (var band in bands)
		{

		    var values = bands[band]
		    values = values.split(";")
		 //   console.log(values)

		    var band_low = values[0];
		    var band_high = values[1];
		    var value = values[2];

		    for (var iBandI = 0; iBandI <  dataHandler.bands.length; ++iBandI )
		    {
			//console.log(dataHandler.bands[iBandI].name)
			var iName = dataHandler.bands[iBandI].regionName;
			var iLow = dataHandler.bands[iBandI].low;
			var iHigh = dataHandler.bands[iBandI].high;

			if (iLow == band_low && iHigh == band_high && iName == name)
			{
			    dataHandler.bands[iBandI].value = value;
			    //console.log(dataHandler.bands[iBandI].value);
			}
		    }

		}

	    }
	}


    }



}
