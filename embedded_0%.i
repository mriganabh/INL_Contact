[Mesh]
  type = FileMesh
  file = disp_inp_embedded_0%.e
  patch_update_strategy = iteration  #For contact
  patch_size = 40
  partitioner = centroid
  centroid_partitioner_direction = y
[]

[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
  [./disp_z]
  [../]
[]

[AuxVariables]
  [./vel_x]
  [../]
  [./accel_x]
  [../]
  [./accel_y]
  [../]
  [./vel_y]
  [../]
  [./vel_z]
  [../]
  [./accel_z]
  [../]
  [./inc_slip_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./acc_slip]
    order = FIRST
    family = LAGRANGE
  [../]
  [./nor_forc]
    order = FIRST
    family = LAGRANGE
  [../]
  [./tang_forc_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Kernels]
  [./TensorMechanics]
    use_displaced_mesh = true
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./gravity]
    type = Gravity
    variable = disp_z
    value = -386.09
  [../]
  [./inertia_x]
    type = InertialForce
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
    gamma = 0.5
    eta=0.0
  [../]
  [./inertia_y]
    type = InertialForce
    variable = disp_y
    velocity = vel_y
    acceleration = accel_y
    beta = 0.25
    gamma = 0.5
    eta=0.0
  [../]
  [./inertia_z]
    type = InertialForce
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    gamma = 0.5
    eta = 0.0
  [../]
[]

[AuxKernels]
  [./inc_slip_x]
    type = PenetrationAux
    variable = inc_slip_x
    quantity = incremental_slip_x
    boundary = 102
    paired_boundary = 111
  [../]
  [./acc_slip]
    type = PenetrationAux
    variable = acc_slip
    quantity = accumulated_slip
    boundary = 102
    paired_boundary = 111
  [../]
  [./nor_forc]
    type = PenetrationAux
    variable = nor_forc
    quantity = normal_force_magnitude
    boundary = 102
    paired_boundary = 111
  [../]
  [./tang_forc_x]
    type = PenetrationAux
    variable = tang_forc_x
    quantity = tangential_force_x
    boundary = 102
    paired_boundary = 111
  [../]
  [./accel_x]
    type = NewmarkAccelAux
    variable = accel_x
    displacement = disp_x
    velocity = vel_x
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./vel_x]
    type = NewmarkVelAux
    variable = vel_x
    acceleration = accel_x
    gamma = 0.5
    execute_on = timestep_end
  [../]
  [./accel_y]
    type = NewmarkAccelAux
    variable = accel_y
    displacement = disp_y
    velocity = vel_y
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./vel_y]
    type = NewmarkVelAux
    variable = vel_y
    acceleration = accel_y
    gamma = 0.5
    execute_on = timestep_end
  [../]
  [./accel_z]
    type = NewmarkAccelAux
    variable = accel_z
    displacement = disp_z
    velocity = vel_z
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./vel_z]
    type = NewmarkVelAux
    variable = vel_z
    acceleration = accel_z
    gamma = 0.5
    execute_on = timestep_end
  [../]
  [./strain_xx]
     type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xx
    index_i = 0
    index_j = 0
  [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
  [../]
  [./strain_zz]
     type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_zz
    index_i = 2
    index_j = 2
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
  [../]
  [./strain_xy]
     type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xy
    index_i = 1
    index_j = 0
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 1
    index_j = 0
  [../]
[]

[BCs]
  [./fix_x_soil]
    type = PresetBC
    variable = disp_x
    boundary = 110
    value = 0.0
  [../]
  [./fix_y_soil]
    type = PresetBC
    variable = disp_y
    boundary = 110
    value = 0.0
  [../]
  [./fix_z_soil]
    type = PresetBC
    variable = disp_z
    boundary = 110
    value = 0.0
  [../]
  [./disp_conc_x]
    type = PresetDisplacement
    boundary = 116
    variable = disp_x
    beta = 0.25                  #try beta=1/6
    velocity = vel_x
    acceleration = accel_x
    function = loading_bc
  [../]
[]

[Functions]
  [./loading_bc]
    type = PiecewiseLinear
    data_file = 'modified_1-cos_func.csv'
    format = 'columns'
    scale_factor = 1
   [../]
[]

[Materials]
  [./elasticity_tensor_block]
    youngs_modulus = 4e6 #psi
    poissons_ratio = 0.25
    type = ComputeIsotropicElasticityTensor
    block = 2
  [../]
  [./strain_block]
    type = ComputeFiniteStrain
    block = 2
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress_block]
    type = ComputeFiniteStrainElasticStress
    block = 2
  [../]
  [./den_block]
    type = GenericConstantMaterial
    block = 2
    prop_names = density
    prop_values = 3e-4 #lb s^2/in ^4    #equivalent to 200pcf
  [../]
  [./elasticity_tensor_soil]
    youngs_modulus = 1.3983e+05 #psi
    poissons_ratio = 0.3
    type = ComputeIsotropicElasticityTensor
    block = 1
  [../]
  [./strain_soil]
    type = ComputeFiniteStrain
    block = 1
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress_soil]
    type = ComputeFiniteStrainElasticStress
    block = 1
  [../]
  [./den_soil]
    type = GenericConstantMaterial
    block = 1
    prop_names = density
    prop_values = 0.0001356 #lb s^2/in^4        #equivalent to 90pcf
  [../]
[]

[Contact]
  [./leftright]
    slave = 102
    master = 111
    system = constraint
    model = coulomb
    friction_coefficient = 0.1
    formulation = penalty
    normalize_penalty = true
    penalty = 1e4
    displacements = 'disp_x disp_y disp_z'
  [../]
[]

[Preconditioning]
  [./andy]
    type = SMP
    full = true
  [../]
[]

[Controls]
  [./inertia_switch]
    type = TimePeriod
    start_time = 0
    end_time = 0.005
    disable_objects = '*/inertia_x */inertia_y */inertia_z */vel_x */vel_y */vel_z */accel_x */accel_y */accel_z'
    set_sync_times = true
  [../]
[]

[Postprocessors]
 [./acc_slip_soil]
    type = SideAverageValue
    variable = acc_slip
    boundary = 111
  [../]
  [./inc_slip_x_soil]
    type = SideAverageValue
    variable = inc_slip_x
    boundary = 111
  [../]
  [./acc_slip_block]
    type = SideAverageValue
    variable = acc_slip
    boundary = 102
  [../]
  [./inc_slip_x_block]
    type = SideAverageValue
    variable = inc_slip_x
    boundary = 102
  [../]
  [./nor_forc]
    type = NodalSum
    variable = nor_forc
    boundary = 102
  [../]
  [./tang_forc_x]
    type = NodalSum
    variable = tang_forc_x
    boundary = 102
  [../]
  [./dispx_soil_bottom]
    type = NodalVariableValue
    variable = disp_x
    nodeid = 4257
   [../]
  [./dispx_soil_top]
    type = NodalVariableValue
    variable = disp_x
    nodeid = 1115
   [../]
  [./dispx_block_bottom]
    type = NodalVariableValue
    variable = disp_x
    nodeid = 5702
   [../]
  [./dispx_block_top]
    type = NodalVariableValue
   variable = disp_x
    nodeid = 5696
   [../]
  [./accx_soil_bottom]
    type = NodalVariableValue
    variable = accel_x
    nodeid = 4257
   [../]
  [./accx_soil_top]
    type = NodalVariableValue
    variable = accel_x
    nodeid = 1115
   [../]
  [./accx_block_bottom]
    type = NodalVariableValue
    variable = accel_x
    nodeid = 5702
   [../]
  [./accx_block_top]
    type = NodalVariableValue
    variable = accel_x
    nodeid = 5696
   [../]
  [./stress_xx_soil_bottom]
    type = PointValue
    variable = stress_xx
    point = '24 24 0'
   [../]
  [./stress_xx_soil_top]
    type = PointValue
    variable = stress_xx
    point = '24 24 48'
   [../]
  [./stress_xx_conc_top]
    type = PointValue
    variable = stress_xx
    point = '24 24 54'
   [../]
  [./stress_zz_soil_bottom]
    type = PointValue
    variable = stress_zz
    point = '24 24 0'
   [../]
  [./stress_zz_soil_top]
    type = PointValue
    variable = stress_zz
    point = '24 24 48'
   [../]
  [./stress_zz_conc_top]
    type = PointValue
    variable = stress_zz
    point = '24 24 54'
   [../]
  [./stress_xy_soil_bottom]
    type = PointValue
    variable = stress_xy
    point = '24 24 0'
   [../]
  [./stress_xy_soil_top]
    type = PointValue
    variable = stress_xy
    point = '24 24 48'
   [../]
  [./stress_xy_conc_top]
    type = PointValue
    variable = stress_xy
    point = '24 24 54'
   [../]
  [./strain_xx_soil_bottom]
   type = PointValue
    variable = strain_xx
    point = '24 24 0'
   [../]
  [./strain_xx_soil_top]
    type = PointValue
    variable = strain_xx
    point = '24 24 48'
   [../]
  [./strain_xx_conc_top]
    type = PointValue
    variable = strain_xx
    point = '24 24 54'
   [../]
  [./strain_zz_soil_bottom]
   type = PointValue
    variable = strain_zz
    point = '24 24 0'
   [../]
  [./strain_zz_soil_top]
    type = PointValue
    variable = strain_zz
    point = '24 24 48'
   [../]
  [./strain_zz_conc_top]
    type = PointValue
    variable = strain_zz
    point = '24 24 54'
   [../]
  [./strain_xy_soil_bottom]
   type = PointValue
    variable = strain_xy
    point = '24 24 0'
   [../]
  [./strain_xy_soil_top]
    type = PointValue
    variable = strain_xy
    point = '24 24 48'
   [../]
  [./strain_xy_conc_top]
    type = PointValue
    variable = strain_xy
    point = '24 24 54'
   [../]
[]

[Executioner]
  type = Transient
  nl_abs_tol = 1e-6
  nl_rel_tol = 1e-6
  l_tol = 1e-6
  l_max_its = 50
  start_time = 0
  end_time = 1.5
  dt = 0.005
  timestep_tolerance = 1e-6
  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu     superlu_dist'
  line_search = 'none'
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = false
  [./screen]
    type = Console
    max_rows = 1
  [../]
[]
