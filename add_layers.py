from array import *
plugins=[
["admin","pink"],["assign","lightgrey"],["availability","lightgreen"],["badge","salmon"],
["backup","lightyellow"],["books","pink"],["blocks","plum"],["cache","lightgreen"],["courses","lightgrey"],["cohort","yellow"],
["chat","lightgreen"],["choice","lightgrey"],["data","blue"]

["events","lightgrey"],["external","lightgreen"],["feedback","salmon"],["forum","yellow"],["glossary","brown"]["grades","pink"],["grading","plum"],
["groups","lightblue"],["lesson","lightgreen"],["lti","blue"],["messages","lightyellow"],["mnet","salmon"],["portfolio","pink"],["quiz","lightgrey"],
["questions","pink"],["questiontype","lightgrey"],["repository","lightgreen"],["roles","plum"],
["resource","lightgrey"],["scorm","yellow"],["stats","lightblue"],["survey","lightgrey"],["tags","lightblue"],["tool","brown"],["users","salmon"],
["wiki","lightgreen"],["workshop","salmon"]
]
d=grt.root.wb.doc.physicalModels[0].addNewDiagram(2500)
d.name='moodle2.8'
d.setPageCounts(3,3)
d.description="Moodle 2.8 Entity Diagram"

x=10
y=250
col=1;
for p in plugins:
            if(p[0]=="admin"):
                layer=d.placeNewLayer(x,y,1000,500,p[0])
                x=x+1050
                col=col+1
            else:
                layer=d.placeNewLayer(x,y,500,500,p[0])
                x=x+550
            layer.color=p[1]
            col=col+1
            if col > 5:
                col=1
                y=y+510
                x=10
               
#for figure in diagram.figures:
#    #figure.columnsExpanded =1
#    print figure.__grtclassname__, figure.name, figure.left, figure.top
#print "OK";

