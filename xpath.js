//  -12345 67890 11 12 13 14 I am new line
var xpath = function(xpathToExecute){
	var result = [];
	var nodesSnapshot = document.evaluate(xpathToExecute, document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null );
	for ( var i=0 ; i < nodesSnapshot.snapshotLength; i++ ){
		result.push( nodesSnapshot.snapshotItem(i) );
	}
	return result;
}
// vim: sw=2
