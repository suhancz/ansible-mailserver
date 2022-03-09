<?php
/* CONFIG START. DO NOT CHANGE ANYTHING IN OR AFTER THIS LINE. */
// $Hash: d98b8a1c440b9220ac24388cab835835a497eb00
// $Id: 48bf0b4cc99e7941b4432a29e70e145b8d654cc7 $
$conf['user']['allow_view_source'] = true;
$conf['server']['server_list'] = 'shown';
$conf['compose']['use_vfs'] = true;
$conf['compose']['link_attachments_notify'] = true;
$conf['compose']['link_attach_threshold'] = 5242880;
$conf['compose']['link_attach_size_limit'] = 0;
$conf['compose']['link_attach_size_hard'] = 0;
$conf['compose']['link_attachments'] = true;
$conf['compose']['attach_size_limit'] = 0;
$conf['compose']['attach_count_limit'] = 0;
$conf['compose']['reply_limit'] = 200000;
$conf['compose']['ac_threshold'] = 3;
$conf['compose']['htmlsig_img_size'] = 30000;
$conf['pgp']['keylength'] = 4096;
$conf['maillog']['driver'] = 'history';
$conf['sentmail']['params']['threshold'] = 60;
$conf['sentmail']['params']['limit_period'] = 24;
$conf['sentmail']['params']['table'] = 'imp_sentmail';
$conf['sentmail']['params']['driverconfig'] = 'horde';
$conf['sentmail']['driver'] = 'Sql';
$conf['contactsimage']['backends'] = array('IMP_Contacts_Avatar_Addressbook', 'IMP_Contacts_Avatar_Gravatar', 'IMP_Contacts_Avatar_Unknown', 'IMP_Contacts_Flag_Host');
$conf['tasklist']['use_tasklist'] = true;
$conf['notepad']['use_notepad'] = true;
/* CONFIG END. DO NOT CHANGE ANYTHING IN OR BEFORE THIS LINE. */
