var xpath = function(xpathToExecute){
	var result = [];
	var nodesSnapshot = document.evaluate(xpathToExecute, document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null );
	for ( var i=0 ; i < nodesSnapshot.snapshotLength; i++ ){
		result.push( nodesSnapshot.snapshotItem(i) );
	}
	return result; -12345
}
// vim: sw=2
// abcdefghijk 000123 456 789
