<?php
// $Id: menu_service.inc,v 1.1.2.4.2.3 2010/05/11 01:43:43 heyrocker Exp $
/**
* @file
* Adds a service type for a menu
*
* @note This file has a 80 character width limit for all lines
*/

/**
* Get the menu from the database.
*
* @param $menu_id
*   The named menu links to return. Defaults to 'primary-links'.

* @return
*   An array of all child menu items from a given menu item.
*/
function emboxd6_service_get($menu_id = NULL) {
  $out = array();
  
  $out['site_name'] = variable_get('site_name', 'drupal');
  $out['site_frontpage'] = variable_get('site_frontpage', 'drupal');
  $out['site_mail'] = variable_get('site_mail', 'drupal');
  $out['site_slogan'] = variable_get('site_slogan', 'drupal');
  $out['site_mission'] = variable_get('site_mission', 'drupal');
  $out['site_footer'] = variable_get('site_footer', 'drupal');
  
  if ($menu_id === NULL || trim($menu_id) === '') {
    $menu_id = 'primary-links';
  }
  $menutree = menu_tree_all_data($menu_id);
  // dpm($menutree, 'menu_tree_all_data');
  $out['menu'] = emboxd6_menu($menutree, $out);
  

  $vocals = taxonomy_get_vocabularies();
  // dpm($vocals, 'taxonomy_get_vocabularies');
  $tmp_vocals = array();
  foreach ( $vocals as $vocal){
    $vocal->terms = taxonomy_get_tree($vocal->vid);
    $tmp_vocals[] = $vocal;
  }
  $out['vocabularies'] = $tmp_vocals;
  
  
  $qry = "SELECT nid FROM {node}";
  $result = db_query($qry);
  while ($obj = db_fetch_object($result)) {
    $node = node_load($obj->nid);
	  $out['nodes'][] =$node;
  }

  // $view = views_get_view('view_all_nodes');
  // $view->render();
  // $view->preview();
  // $out['view'] =$view->result;


  return $out;
}

/**
* Recursively returns menu items.
*
* @param $data
*   The menu item whose children should be returned
* @return
*   Array. All children menu items from a given menu item.
*/
function emboxd6_menu($data, &$out) {
  $menu = array();
  
  if (is_array($data)) {
    foreach ($data as $item) {
      // dpm($item, 'item');
      $tmp = new stdClass;
      $tmp = (object) $item['link'];
      $tmp->children = emboxd6_menu($item['below'], $out);
      $tmp->path = drupal_get_path_alias($item['link']['link_path']);
      
      
      if ($item['link']['page_callback'] == 'i18ntaxonomy_term_page' ||  $item['link']['page_callback'] == 'taxonomy_term_page' ){
        $tidsstring = substr($item['link']['href'], 14);
        $tids = explode(" ",$tidsstring);
        $tmp->tids = $tids;
        
        $result = taxonomy_select_nodes($tids);
        $nodes = array();
        $types = array();
        while ($node = db_fetch_object($result)) {
          $node_loaded = node_load($node->nid);
          $nodes[] = $node->nid;
          $types[] = $node_loaded->type;
        }
        $tmp->ref_nids = $nodes;
        $tmp->ref_types = $types;
	      $tmp->type = 'ctype_taxonomy';
				$out['nodes'][] = $tmp;
      }
      
      elseif ($item['link']['page_callback'] == 'node_page_view'){
        $nidsstring = substr($item['link']['href'], 5);
        $node_loaded = node_load($nidsstring);
        $tmp->ref_nid = $nidsstring;
        $tmp->ref_type = $node_loaded->type;
      }
      
      elseif ($item['link']['page_callback'] == 'menu_item_container'){
        $nidsstring = substr($item['link']['href'], 20);
        $tmp->ref_micid = $nidsstring;
      }
			
			elseif ($item['link']['href'] == 'contact'){
	      $tmp->title = $item['link']['link_title'];
	      $tmp->type = 'ctype_contact';
	      $tmp->href = $item['link']['href'];
	      $tmp->ref_type = 'contact_form';
	      $tmp->load = contact_load(1);
				$out['nodes'][] = $tmp;
    }
      
      $menu[] = $tmp;
    }
  }

  return $menu;
}