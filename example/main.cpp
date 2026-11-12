#include <Omega_h_library.hpp>
#include <Omega_h_mesh.hpp>
#include <Omega_h_file.hpp>
#include <iostream>

int main(int argc, char** argv) {
  auto lib = Omega_h::Library(&argc, &argv);

  if (argc != 3) 
	std::cerr << "usage: exo2vtk in.exo out_vtk_dir\n"; return 1; 

  auto mesh = Omega_h::Mesh(&lib);
  int file = Omega_h::exodus::open(argv[1]);

  Omega_h::exodus::read_mesh(file, &mesh);
  Omega_h::exodus::close(file);
  std::cout << "dim=" << mesh.dim() << " verts=" << mesh.nverts()<< " elems=" << mesh.nelems() << "\n";

  Omega_h::vtk::write_parallel(argv[2], &mesh);


  return 0;
}
