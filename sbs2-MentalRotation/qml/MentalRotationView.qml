import QtQuick 1.1

Item {
    id: mentalRotationView

    width: imageGrid.width
    height: imageGrid.height

    Grid {
        id: imageGrid
        // We assume that all images are the same size
        columns: page.isPortrait ? 1 : 2
        rows: page.isPortrait ? 2 : 1
        spacing: 5

        property string imageBasePath: AppSettings.value("ImageBasePath","")  // shoud already be set in main.cpp

        Component.onCompleted: {
            setImage(0,2,'x',145,false);
            setImage(1,2,'x',145,true);
        }

        /*
         * pos:       0 or 1 (left/right in landscape, top/bottom in portrait - might be more in the future)
         * setno:     1 - 16  (the image set number)
         * axis:      'x' or 'z'
         * deg:       rotation degrees in steps of 5 (0, 5, 10, ... 355)
         */
        function setImage(pos, setno, axis, deg, mirrored){
            // validate inputs (roughly)
            var validated = true;
            if (!(pos === 0 || pos === 1)) {
                console.log("setImage:  pos must be 0 or 1");
                validated = false;
            }
            if (!(setno >= 1 && setno <=16)) {
                console.log("setImage:  setno must be [1;16]");
                validated = false;
            }
            if (!(axis === 'x' || axis === 'z')) {
                console.log("setImage:  axis must be 'x' or 'z'");
                validated = false;
            }
            if (!((deg*0.2) === Math.floor(deg*0.2) && deg >= 0 && deg <= 355)) {
                console.log("setImage:  deg must be [0,5,10,...,355]")
                validated = false;
            }
            if (!validated)
                return;

            var imgObj;
            if (pos === 0)
                imgObj = image1;
            else
                imgObj = image2;

            var srcStr = imageBasePath + "/jpg/" + axis + "/" + setno + "_" + axis + "_" + deg + (mirrored?"_b":"_a") + ".jpg";
            console.debug("Loading (pos="+pos+"): " + srcStr);

            imgObj.source = srcStr;
        }

        Image {
            id: image1
        }

        Image {
            id: image2
        }
    }
}
