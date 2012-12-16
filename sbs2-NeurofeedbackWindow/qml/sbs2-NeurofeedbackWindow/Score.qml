import QtQuick 1.0

Rectangle {
    width: 100
    height: 62
    id: score

    property double chosenScore: 0;

    function setScore(scoreValue)
    {
	for (var child = 0; child < scoreGrid.children.length; ++child)
	{
	    var c = scoreGrid.children[child]
	    var v = c.value;
	    if (v <= scoreValue)
		c.color = "red"
	    else
		c.color = "black"
	}

	score.chosenScore = scoreValue;
    }

    Grid
    {
	id: scoreGrid
	rows: 1
	spacing: 10
	ScoreNumber{value: 1}
	ScoreNumber{value: 2}
	ScoreNumber{value: 3}
	ScoreNumber{value: 4}
	ScoreNumber{value: 5}
    }

}
