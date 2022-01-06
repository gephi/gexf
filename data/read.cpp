#include <stdlib.h>

// if libgexf is installed
#include <libgexf/libgexf.h>

libgexf::GEXF read() {

    // read
    libgexf::FileReader* reader = new libgexf::FileReader();
    reader->init("in.gexf");
    reader->slurp();

    return reader->getGEXFCopy();
}


int main(int argc, char** argv) {

    read();

    return (EXIT_SUCCESS);
}

