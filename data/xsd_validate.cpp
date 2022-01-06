#include <stdlib.h>

// if libgexf is installed
#include <libgexf/libgexf.h>

void validate() {

    bool res = libgexf::SchemaValidator::run( "path/to/my/file.gexf",
                                              "/usr/include/libgexf/resources/xsd/gexf.xsd");
    std::cout << "isValid: " << res << std::endl;

}


int main(int argc, char** argv) {

    validate();

    return (EXIT_SUCCESS);
}

