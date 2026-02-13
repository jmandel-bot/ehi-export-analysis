// You can find instructions for this file here:
// http://www.treeview.net

// Decide if the names are links or just the icons
USETEXTLINKS = 1  //replace 0 with 1 for hyperlinks

// Decide if the tree is to start all open or just showing the root folders
STARTALLOPEN = 0 //replace 0 with 1 to show the whole tree

ICONPATH = 'Support/' //change if the gif's folder is a subfolder, for example: 'images/'


USEICONS = 1

{
foldersTree = gFld("Title", "title.htm")
foldersTree.iconSrc = ICONPATH + "Gif/globe.gif"
Diag_Node = insFld(foldersTree, gFld("EHI", "diagram.htm"))
Diag_Node.iconSrc = ICONPATH + "Gif/ERSTUDIO.gif"
Diag_Node.iconSrcClosed = ICONPATH + "Gif/ERSTUDIO.gif"
Model_Node = insFld(Diag_Node, gFld("Physical", "javascript:parent.op()"))
Model_Node.iconSrc = ICONPATH + "Gif/physical.gif"
Model_Node.iconSrcClosed = ICONPATH + "Gif/physical.gif"
{
Submodel_6ce78c092c134b7fb0f9f94ed8a395d4 = insFld(Model_Node, gFld("Main Model", "javascript:parent.op()"))
Submodel_6ce78c092c134b7fb0f9f94ed8a395d4.iconSrc = ICONPATH + "Gif/grnfldr.gif"
Submodel_6ce78c092c134b7fb0f9f94ed8a395d4.iconSrcClosed = ICONPATH + "Gif/grnfldr.gif"
EntityFolder = insFld(Submodel_6ce78c092c134b7fb0f9f94ed8a395d4, gFld("Tables", "Content/Sub_6ce78c092c134b7fb0f9f94ed8a395d4_EntFrame.htm"))
EntityFolder.iconSrc = ICONPATH + "Gif/entfldr.gif"
EntityFolder.iconSrcClosed = ICONPATH + "Gif/entfldr.gif"
//AttrFolder = insFld(Submodel_6ce78c092c134b7fb0f9f94ed8a395d4, gFld("Columns", "Content/Sub_6ce78c092c134b7fb0f9f94ed8a395d4_AttrFrame.htm"))
//AttrFolder.iconSrc = ICONPATH + "Gif/attr.gif"
//AttrFolder.iconSrcClosed = ICONPATH + "Gif/attr.gif"
}
}
