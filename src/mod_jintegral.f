c     ****************************************************************
c     *                                                              *
c     *                    f-90 module j_data                        *
c     *                                                              *
c     *                       written by : rhd                       *
c     *                                                              *
c     *              last modified : 12/20/12 rhd                    *
c     *                   moved front_node_displ(3,max_front_nodes)  *
c     *                   here rather than local in didriv.f
c     *     define the variables and data structures to support      *
c     *     j-integral computations                                  *
c     *                                                              *
c     ****************************************************************
c
c
c
      module j_data
c
c                     max sets and front nodes should be
c                     same value
c
      parameter (max_node_set=200, max_ct_node=80,
     &           max_front_nodes=200, max_domain_rings=300 )
c
c                     double precision/reals
c
#dbl       double precision
#sgl       real
     & crack_plane_normal(3), crack_front_tangent(3),
     & domain_rot(3,3), domain_min_j, domain_max_j, domain_avg_j,
     & static_min, static_max, static_avg,  front_q_area, front_length,
     & front_coords(3,max_front_nodes),
     & domain_min_i(10), domain_max_i(10), domain_avg_i(10),
     & cf_tractions(3), box_tol_relat, e33_front, e_front, nu_front,
     & crack_curvature(7), front_node_displ(3,max_front_nodes)
c
c                     integers
c
      integer
     & num_front_nodes, front_nodes(max_front_nodes), front_order,
     & nowring, ring_list(max_domain_rings), domain_type, last_compr,
     & max_node_set_id, num_auto_rings, domain_origin, max_exp_front
      integer, save :: ring_count
      integer, save, allocatable, dimension (:,:) :: compr_q_list,
     &                                               node_set,
     &                                              expanded_front_nodes
      integer, save, allocatable, dimension (:)   :: q_element_maps
      integer, save, allocatable, dimension (:)   :: count_alpha
      integer, save, allocatable, dimension (:)   :: extrap_counts
c
c                     reals
c
      real, save, allocatable, dimension(:) ::   q_values, seg_snode_e,
     &                                           seg_snode_nu
      real, save, allocatable, dimension(:,:) :: snode_alpha_ij
c
c                     real/double
c
#dbl       double precision,
#sgl       real,
     & allocatable, dimension(:), save :: swd_at_nodes
c
#dbl       double precision,
#sgl       real,
     & allocatable, dimension(:,:), save :: strain_at_nodes, j_storage,
     &                                      j_from_ks, ks_from_j
#dbl       double precision,
#sgl       real,
     & allocatable, dimension(:,:,:), save :: i_storage
c
c                     logicals
c
      logical ::
     & verify_front, symmetric_domain, qvals_given, rings_given,
     & print_totals, print_elem_values, q_vals_linear,
     & debug_driver, debug_elements, one_point_rule, static_j,
     & ignore_face_loads, first_domain, process_velocities,
     & process_accels, omit_crack_front_elems, fgm_e, fgm_nu,
     & output_packet_j, output_packet_i, comput_j, comput_i,
     & out_pstress, out_pstrain, cf_traction_flags(3), j_to_k,
     & process_temperatures, face_loading, tangent_vector_defined
c
      logical, save, allocatable, dimension (:) :: crack_front_elem,
     &                                             block_seg_curves
c
c                     characters
c
      character * 24
     & domain_id
c
      end module

