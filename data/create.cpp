#include <stdlib.h>

// if libgexf is installed
#include <libgexf/libgexf.h>

void create() {

    libgexf::GEXF *gexf = new libgexf::GEXF();

    libgexf::DirectedGraph& graph = gexf->getDirectedGraph();

    // nodes
    graph.addNode("0");
    graph.addNode("1");

    // edges
    graph.addEdge("0", "0", "1");

    // node labels
    libgexf::Data& data = gexf->getData();
    data.setLabel("0", "Hello");
    data.setLabel("1", "world");

    // attributes
    data.addNodeAttributeColumn("0", "foo", libgexf::BOOLEAN);
    data.setNodeAttributeDefault("0", "false");
    data.setNodeValue("1", "0", "true");

    // meta data
    libgexf::MetaData& meta = gexf->getMetaData();
    meta.setCreator("me, myself and I");
    meta.setDescription("The answer is 42.");

    // Dump
    std::cout << "Dump:" << std::endl << *gexf;
}


int main(int argc, char** argv) {

    create();

    return (EXIT_SUCCESS);
}

