
using Skyrmions3D

a_skyrmion = Skyrmion(5,0.2)
b_skyrmion = Skyrmion(6,0.2)

@test_throws Exception product_approx(a_skyrmion, b_skyrmion)

b_skyrmion = Skyrmion(5,0.2)

@test product_approx(a_skyrmion, b_skyrmion).pion_field == a_skyrmion.pion_field

product_approx!(a_skyrmion, b_skyrmion)
@test b_skyrmion.pion_field == a_skyrmion.pion_field

translate_sk!(a_skyrmion, [0.0,0.0,-4.0])
@test a_skyrmion.pion_field == b_skyrmion.pion_field


# Check if transformations work in the same way for rational maps and post-RM transforms.
# Need to actually make a B=1

a_skyrmion = Skyrmion(5,0.2)
b_skyrmion = Skyrmion(5,0.2)
set_neumann!(a_skyrmion)
set_neumann!(b_skyrmion)

p(z) = z;
q(z) = 1;
f(r) = pi*exp( -(r.^3)./12.0 )
make_rational_map!(a_skyrmion, p, q, f)

for X0 in [ [0.2,0,0,0,0], [-0.2,0.0,0.0], [0.0,0.2,0.0], [0.0,-0.2,0.0], [0.0,0.0,0.2], [0.0,0.0,-0.2] ]

    make_rational_map!(a_skyrmion, p, q, f)
    make_rational_map!(b_skyrmion, p, q, f, X=X0)
    @test translate_sk(a_skyrmion, X0).pion_field[3,3,3,:] ≈ b_skyrmion.pion_field[3,3,3,:]

end




