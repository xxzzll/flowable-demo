create table act_cmmn_databasechangelog
(
    id            varchar(255) not null,
    author        varchar(255) not null,
    filename      varchar(255) not null,
    dateexecuted  datetime     not null,
    orderexecuted int          not null,
    exectype      varchar(10)  not null,
    md5sum        varchar(35)  null,
    description   varchar(255) null,
    comments      varchar(255) null,
    tag           varchar(255) null,
    liquibase     varchar(20)  null,
    contexts      varchar(255) null,
    labels        varchar(255) null,
    deployment_id varchar(10)  null
);

create table act_cmmn_databasechangeloglock
(
    id          int          not null
        primary key,
    locked      bit          not null,
    lockgranted datetime     null,
    lockedby    varchar(255) null
);

create table act_cmmn_deployment
(
    id_                   varchar(255)            not null
        primary key,
    name_                 varchar(255)            null,
    category_             varchar(255)            null,
    key_                  varchar(255)            null,
    deploy_time_          datetime                null,
    parent_deployment_id_ varchar(255)            null,
    tenant_id_            varchar(255) default '' null
);

create table act_cmmn_casedef
(
    id_                     varchar(255)            not null
        primary key,
    rev_                    int                     not null,
    name_                   varchar(255)            null,
    key_                    varchar(255)            not null,
    version_                int                     not null,
    category_               varchar(255)            null,
    deployment_id_          varchar(255)            null,
    resource_name_          varchar(4000)           null,
    description_            varchar(4000)           null,
    has_graphical_notation_ bit                     null,
    tenant_id_              varchar(255) default '' null,
    dgrm_resource_name_     varchar(4000)           null,
    has_start_form_key_     bit                     null,
    constraint act_fk_case_def_dply
        foreign key (deployment_id_) references act_cmmn_deployment (id_)
);

create index act_idx_case_def_dply
    on act_cmmn_casedef (deployment_id_);

create table act_cmmn_deployment_resource
(
    id_             varchar(255) not null
        primary key,
    name_           varchar(255) null,
    deployment_id_  varchar(255) null,
    resource_bytes_ longblob     null,
    generated_      bit          null,
    constraint act_fk_cmmn_rsrc_dpl
        foreign key (deployment_id_) references act_cmmn_deployment (id_)
);

create index act_idx_cmmn_rsrc_dpl
    on act_cmmn_deployment_resource (deployment_id_);

create table act_cmmn_hi_case_inst
(
    id_            varchar(255)            not null
        primary key,
    rev_           int                     not null,
    business_key_  varchar(255)            null,
    name_          varchar(255)            null,
    parent_id_     varchar(255)            null,
    case_def_id_   varchar(255)            null,
    state_         varchar(255)            null,
    start_time_    datetime                null,
    end_time_      datetime                null,
    start_user_id_ varchar(255)            null,
    callback_id_   varchar(255)            null,
    callback_type_ varchar(255)            null,
    tenant_id_     varchar(255) default '' null
);

create table act_cmmn_hi_mil_inst
(
    id_           varchar(255) not null
        primary key,
    rev_          int          not null,
    name_         varchar(255) not null,
    time_stamp_   datetime     not null,
    case_inst_id_ varchar(255) not null,
    case_def_id_  varchar(255) not null,
    element_id_   varchar(255) not null
);

create table act_cmmn_ru_case_inst
(
    id_              varchar(255)            not null
        primary key,
    rev_             int                     not null,
    business_key_    varchar(255)            null,
    name_            varchar(255)            null,
    parent_id_       varchar(255)            null,
    case_def_id_     varchar(255)            null,
    state_           varchar(255)            null,
    start_time_      datetime                null,
    start_user_id_   varchar(255)            null,
    callback_id_     varchar(255)            null,
    callback_type_   varchar(255)            null,
    tenant_id_       varchar(255) default '' null,
    lock_time_       datetime                null,
    is_completeable_ bit                     null,
    constraint act_fk_case_inst_case_def
        foreign key (case_def_id_) references act_cmmn_casedef (id_)
);

create index act_idx_case_inst_case_def
    on act_cmmn_ru_case_inst (case_def_id_);

create index act_idx_case_inst_parent
    on act_cmmn_ru_case_inst (parent_id_);

create table act_cmmn_ru_mil_inst
(
    id_           varchar(255) not null
        primary key,
    name_         varchar(255) not null,
    time_stamp_   datetime     not null,
    case_inst_id_ varchar(255) not null,
    case_def_id_  varchar(255) not null,
    element_id_   varchar(255) not null,
    constraint act_fk_mil_case_def
        foreign key (case_def_id_) references act_cmmn_casedef (id_),
    constraint act_fk_mil_case_inst
        foreign key (case_inst_id_) references act_cmmn_ru_case_inst (id_)
);

create index act_idx_mil_case_def
    on act_cmmn_ru_mil_inst (case_def_id_);

create index act_idx_mil_case_inst
    on act_cmmn_ru_mil_inst (case_inst_id_);

create table act_cmmn_ru_plan_item_inst
(
    id_                     varchar(255)            not null
        primary key,
    rev_                    int                     not null,
    case_def_id_            varchar(255)            null,
    case_inst_id_           varchar(255)            null,
    stage_inst_id_          varchar(255)            null,
    is_stage_               bit                     null,
    element_id_             varchar(255)            null,
    name_                   varchar(255)            null,
    state_                  varchar(255)            null,
    start_time_             datetime                null,
    start_user_id_          varchar(255)            null,
    reference_id_           varchar(255)            null,
    reference_type_         varchar(255)            null,
    tenant_id_              varchar(255) default '' null,
    item_definition_id_     varchar(255)            null,
    item_definition_type_   varchar(255)            null,
    is_completeable_        bit                     null,
    is_count_enabled_       bit                     null,
    var_count_              int                     null,
    sentry_part_inst_count_ int                     null,
    constraint act_fk_plan_item_case_def
        foreign key (case_def_id_) references act_cmmn_casedef (id_),
    constraint act_fk_plan_item_case_inst
        foreign key (case_inst_id_) references act_cmmn_ru_case_inst (id_)
);

create index act_idx_plan_item_case_def
    on act_cmmn_ru_plan_item_inst (case_def_id_);

create index act_idx_plan_item_case_inst
    on act_cmmn_ru_plan_item_inst (case_inst_id_);

create index act_idx_plan_item_stage_inst
    on act_cmmn_ru_plan_item_inst (stage_inst_id_);

create table act_cmmn_ru_sentry_part_inst
(
    id_                varchar(255) not null
        primary key,
    rev_               int          not null,
    case_def_id_       varchar(255) null,
    case_inst_id_      varchar(255) null,
    plan_item_inst_id_ varchar(255) null,
    on_part_id_        varchar(255) null,
    if_part_id_        varchar(255) null,
    time_stamp_        datetime     null,
    constraint act_fk_sentry_case_def
        foreign key (case_def_id_) references act_cmmn_casedef (id_),
    constraint act_fk_sentry_case_inst
        foreign key (case_inst_id_) references act_cmmn_ru_case_inst (id_),
    constraint act_fk_sentry_plan_item
        foreign key (plan_item_inst_id_) references act_cmmn_ru_plan_item_inst (id_)
);

create index act_idx_sentry_case_def
    on act_cmmn_ru_sentry_part_inst (case_def_id_);

create index act_idx_sentry_case_inst
    on act_cmmn_ru_sentry_part_inst (case_inst_id_);

create index act_idx_sentry_plan_item
    on act_cmmn_ru_sentry_part_inst (plan_item_inst_id_);

create table act_co_content_item
(
    id_                 varchar(255)        not null
        primary key,
    name_               varchar(255)        not null,
    mime_type_          varchar(255)        null,
    task_id_            varchar(255)        null,
    proc_inst_id_       varchar(255)        null,
    content_store_id_   varchar(255)        null,
    content_store_name_ varchar(255)        null,
    field_              varchar(400)        null,
    content_available_  bit    default b'0' null,
    created_            timestamp(6)        null,
    created_by_         varchar(255)        null,
    last_modified_      timestamp(6)        null,
    last_modified_by_   varchar(255)        null,
    content_size_       bigint default 0    null,
    tenant_id_          varchar(255)        null,
    scope_id_           varchar(255)        null,
    scope_type_         varchar(255)        null
);

create index idx_contitem_procid
    on act_co_content_item (proc_inst_id_);

create index idx_contitem_scope
    on act_co_content_item (scope_id_, scope_type_);

create index idx_contitem_taskid
    on act_co_content_item (task_id_);

create table act_co_databasechangelog
(
    id            varchar(255) not null,
    author        varchar(255) not null,
    filename      varchar(255) not null,
    dateexecuted  datetime     not null,
    orderexecuted int          not null,
    exectype      varchar(10)  not null,
    md5sum        varchar(35)  null,
    description   varchar(255) null,
    comments      varchar(255) null,
    tag           varchar(255) null,
    liquibase     varchar(20)  null,
    contexts      varchar(255) null,
    labels        varchar(255) null,
    deployment_id varchar(10)  null
);

create table act_co_databasechangeloglock
(
    id          int          not null
        primary key,
    locked      bit          not null,
    lockgranted datetime     null,
    lockedby    varchar(255) null
);

create table act_de_databasechangelog
(
    id            varchar(255) not null,
    author        varchar(255) not null,
    filename      varchar(255) not null,
    dateexecuted  datetime     not null,
    orderexecuted int          not null,
    exectype      varchar(10)  not null,
    md5sum        varchar(35)  null,
    description   varchar(255) null,
    comments      varchar(255) null,
    tag           varchar(255) null,
    liquibase     varchar(20)  null,
    contexts      varchar(255) null,
    labels        varchar(255) null,
    deployment_id varchar(10)  null
);

create table act_de_databasechangeloglock
(
    id          int          not null
        primary key,
    locked      bit          not null,
    lockgranted datetime     null,
    lockedby    varchar(255) null
);

create table act_de_model
(
    id                varchar(255)  not null
        primary key,
    name              varchar(400)  not null,
    model_key         varchar(400)  not null,
    description       varchar(4000) null,
    model_comment     varchar(4000) null,
    created           datetime(6)   null,
    created_by        varchar(255)  null,
    last_updated      datetime(6)   null,
    last_updated_by   varchar(255)  null,
    version           int           null,
    model_editor_json longtext      null,
    thumbnail         longblob      null,
    model_type        int           null,
    tenant_id         varchar(255)  null
);

create index idx_proc_mod_created
    on act_de_model (created_by);

create table act_de_model_history
(
    id                varchar(255)  not null
        primary key,
    name              varchar(400)  not null,
    model_key         varchar(400)  not null,
    description       varchar(4000) null,
    model_comment     varchar(4000) null,
    created           datetime(6)   null,
    created_by        varchar(255)  null,
    last_updated      datetime(6)   null,
    last_updated_by   varchar(255)  null,
    removal_date      datetime(6)   null,
    version           int           null,
    model_editor_json longtext      null,
    model_id          varchar(255)  not null,
    model_type        int           null,
    tenant_id         varchar(255)  null
);

create index idx_proc_mod_history_proc
    on act_de_model_history (model_id);

create table act_de_model_relation
(
    id              varchar(255) not null
        primary key,
    parent_model_id varchar(255) null,
    model_id        varchar(255) null,
    relation_type   varchar(255) null,
    constraint fk_relation_child
        foreign key (model_id) references act_de_model (id),
    constraint fk_relation_parent
        foreign key (parent_model_id) references act_de_model (id)
);

create table act_dmn_databasechangelog
(
    id            varchar(255) not null,
    author        varchar(255) not null,
    filename      varchar(255) not null,
    dateexecuted  datetime     not null,
    orderexecuted int          not null,
    exectype      varchar(10)  not null,
    md5sum        varchar(35)  null,
    description   varchar(255) null,
    comments      varchar(255) null,
    tag           varchar(255) null,
    liquibase     varchar(20)  null,
    contexts      varchar(255) null,
    labels        varchar(255) null,
    deployment_id varchar(10)  null
);

create table act_dmn_databasechangeloglock
(
    id          int          not null
        primary key,
    locked      bit          not null,
    lockgranted datetime     null,
    lockedby    varchar(255) null
);

create table act_dmn_decision_table
(
    id_                   varchar(255) not null
        primary key,
    name_                 varchar(255) null,
    version_              int          null,
    key_                  varchar(255) null,
    category_             varchar(255) null,
    deployment_id_        varchar(255) null,
    parent_deployment_id_ varchar(255) null,
    tenant_id_            varchar(255) null,
    resource_name_        varchar(255) null,
    description_          varchar(255) null
);

create table act_dmn_deployment
(
    id_                   varchar(255) not null
        primary key,
    name_                 varchar(255) null,
    category_             varchar(255) null,
    deploy_time_          datetime     null,
    tenant_id_            varchar(255) null,
    parent_deployment_id_ varchar(255) null
);

create table act_dmn_deployment_resource
(
    id_             varchar(255) not null
        primary key,
    name_           varchar(255) null,
    deployment_id_  varchar(255) null,
    resource_bytes_ longblob     null
);

create table act_dmn_hi_decision_execution
(
    id_                     varchar(255)     not null
        primary key,
    decision_definition_id_ varchar(255)     null,
    deployment_id_          varchar(255)     null,
    start_time_             datetime         null,
    end_time_               datetime         null,
    instance_id_            varchar(255)     null,
    execution_id_           varchar(255)     null,
    activity_id_            varchar(255)     null,
    failed_                 bit default b'0' null,
    tenant_id_              varchar(255)     null,
    execution_json_         longtext         null,
    scope_type_             varchar(255)     null
);

create table act_evt_log
(
    log_nr_       bigint auto_increment
        primary key,
    type_         varchar(64)                               null,
    proc_def_id_  varchar(64)                               null,
    proc_inst_id_ varchar(64)                               null,
    execution_id_ varchar(64)                               null,
    task_id_      varchar(64)                               null,
    time_stamp_   timestamp(3) default current_timestamp(3) not null on update current_timestamp(3),
    user_id_      varchar(255)                              null,
    data_         longblob                                  null,
    lock_owner_   varchar(255)                              null,
    lock_time_    timestamp(3)                              null,
    is_processed_ tinyint      default 0                    null
)
    comment '事件日志表' collate = utf8_bin;

create table act_fo_databasechangelog
(
    id            varchar(255) not null,
    author        varchar(255) not null,
    filename      varchar(255) not null,
    dateexecuted  datetime     not null,
    orderexecuted int          not null,
    exectype      varchar(10)  not null,
    md5sum        varchar(35)  null,
    description   varchar(255) null,
    comments      varchar(255) null,
    tag           varchar(255) null,
    liquibase     varchar(20)  null,
    contexts      varchar(255) null,
    labels        varchar(255) null,
    deployment_id varchar(10)  null
);

create table act_fo_databasechangeloglock
(
    id          int          not null
        primary key,
    locked      bit          not null,
    lockgranted datetime     null,
    lockedby    varchar(255) null
);

create table act_fo_form_definition
(
    id_                   varchar(255) not null
        primary key,
    name_                 varchar(255) null,
    version_              int          null,
    key_                  varchar(255) null,
    category_             varchar(255) null,
    deployment_id_        varchar(255) null,
    parent_deployment_id_ varchar(255) null,
    tenant_id_            varchar(255) null,
    resource_name_        varchar(255) null,
    description_          varchar(255) null
);

create table act_fo_form_deployment
(
    id_                   varchar(255) not null
        primary key,
    name_                 varchar(255) null,
    category_             varchar(255) null,
    deploy_time_          datetime     null,
    tenant_id_            varchar(255) null,
    parent_deployment_id_ varchar(255) null
);

create table act_fo_form_instance
(
    id_                  varchar(255) not null
        primary key,
    form_definition_id_  varchar(255) not null,
    task_id_             varchar(255) null,
    proc_inst_id_        varchar(255) null,
    proc_def_id_         varchar(255) null,
    submitted_date_      datetime     null,
    submitted_by_        varchar(255) null,
    form_values_id_      varchar(255) null,
    tenant_id_           varchar(255) null,
    scope_id_            varchar(255) null,
    scope_type_          varchar(255) null,
    scope_definition_id_ varchar(255) null
);

create table act_fo_form_resource
(
    id_             varchar(255) not null
        primary key,
    name_           varchar(255) null,
    deployment_id_  varchar(255) null,
    resource_bytes_ longblob     null
);

create table act_ge_property
(
    name_  varchar(64)  not null
        primary key,
    value_ varchar(300) null,
    rev_   int          null
)
    comment '系统相关属性' collate = utf8_bin;

create table act_hi_actinst
(
    id_                varchar(64)             not null
        primary key,
    rev_               int          default 1  null,
    proc_def_id_       varchar(64)             not null,
    proc_inst_id_      varchar(64)             not null,
    execution_id_      varchar(64)             not null,
    act_id_            varchar(255)            not null,
    task_id_           varchar(64)             null,
    call_proc_inst_id_ varchar(64)             null,
    act_name_          varchar(255)            null,
    act_type_          varchar(255)            not null,
    assignee_          varchar(255)            null,
    start_time_        datetime(3)             not null,
    end_time_          datetime(3)             null,
    duration_          bigint                  null,
    delete_reason_     varchar(4000)           null,
    tenant_id_         varchar(255) default '' null
)
    comment '历史的流程实例' collate = utf8_bin;

create index act_idx_hi_act_inst_end
    on act_hi_actinst (end_time_);

create index act_idx_hi_act_inst_exec
    on act_hi_actinst (execution_id_, act_id_);

create index act_idx_hi_act_inst_procinst
    on act_hi_actinst (proc_inst_id_, act_id_);

create index act_idx_hi_act_inst_start
    on act_hi_actinst (start_time_);

create table act_hi_attachment
(
    id_           varchar(64)   not null
        primary key,
    rev_          int           null,
    user_id_      varchar(255)  null,
    name_         varchar(255)  null,
    description_  varchar(4000) null,
    type_         varchar(255)  null,
    task_id_      varchar(64)   null,
    proc_inst_id_ varchar(64)   null,
    url_          varchar(4000) null,
    content_id_   varchar(64)   null,
    time_         datetime(3)   null
)
    comment '历史的流程附件' collate = utf8_bin;

create table act_hi_comment
(
    id_           varchar(64)   not null
        primary key,
    type_         varchar(255)  null,
    time_         datetime(3)   not null,
    user_id_      varchar(255)  null,
    task_id_      varchar(64)   null,
    proc_inst_id_ varchar(64)   null,
    action_       varchar(255)  null,
    message_      varchar(4000) null,
    full_msg_     longblob      null
)
    comment '历史的说明性信息' collate = utf8_bin;

create table act_hi_detail
(
    id_           varchar(64)   not null
        primary key,
    type_         varchar(255)  not null,
    proc_inst_id_ varchar(64)   null,
    execution_id_ varchar(64)   null,
    task_id_      varchar(64)   null,
    act_inst_id_  varchar(64)   null,
    name_         varchar(255)  not null,
    var_type_     varchar(255)  null,
    rev_          int           null,
    time_         datetime(3)   not null,
    bytearray_id_ varchar(64)   null,
    double_       double        null,
    long_         bigint        null,
    text_         varchar(4000) null,
    text2_        varchar(4000) null
)
    comment '历史的流程运行中的细节信息' collate = utf8_bin;

create index act_idx_hi_detail_act_inst
    on act_hi_detail (act_inst_id_);

create index act_idx_hi_detail_name
    on act_hi_detail (name_);

create index act_idx_hi_detail_proc_inst
    on act_hi_detail (proc_inst_id_);

create index act_idx_hi_detail_task_id
    on act_hi_detail (task_id_);

create index act_idx_hi_detail_time
    on act_hi_detail (time_);

create table act_hi_entitylink
(
    id_                      varchar(64)  not null
        primary key,
    link_type_               varchar(255) null,
    create_time_             datetime(3)  null,
    scope_id_                varchar(255) null,
    scope_type_              varchar(255) null,
    scope_definition_id_     varchar(255) null,
    ref_scope_id_            varchar(255) null,
    ref_scope_type_          varchar(255) null,
    ref_scope_definition_id_ varchar(255) null,
    hierarchy_type_          varchar(255) null
)
    collate = utf8_bin;

create index act_idx_hi_ent_lnk_scope
    on act_hi_entitylink (scope_id_, scope_type_, link_type_);

create index act_idx_hi_ent_lnk_scope_def
    on act_hi_entitylink (scope_definition_id_, scope_type_, link_type_);

create table act_hi_identitylink
(
    id_                  varchar(64)  not null
        primary key,
    group_id_            varchar(255) null,
    type_                varchar(255) null,
    user_id_             varchar(255) null,
    task_id_             varchar(64)  null,
    create_time_         datetime(3)  null,
    proc_inst_id_        varchar(64)  null,
    scope_id_            varchar(255) null,
    scope_type_          varchar(255) null,
    scope_definition_id_ varchar(255) null
)
    comment '历史的流程运行过程中用户关系' collate = utf8_bin;

create index act_idx_hi_ident_lnk_procinst
    on act_hi_identitylink (proc_inst_id_);

create index act_idx_hi_ident_lnk_scope
    on act_hi_identitylink (scope_id_, scope_type_);

create index act_idx_hi_ident_lnk_scope_def
    on act_hi_identitylink (scope_definition_id_, scope_type_);

create index act_idx_hi_ident_lnk_task
    on act_hi_identitylink (task_id_);

create index act_idx_hi_ident_lnk_user
    on act_hi_identitylink (user_id_);

create table act_hi_procinst
(
    id_                        varchar(64)             not null
        primary key,
    rev_                       int          default 1  null,
    proc_inst_id_              varchar(64)             not null,
    business_key_              varchar(255)            null,
    proc_def_id_               varchar(64)             not null,
    start_time_                datetime(3)             not null,
    end_time_                  datetime(3)             null,
    duration_                  bigint                  null,
    start_user_id_             varchar(255)            null,
    start_act_id_              varchar(255)            null,
    end_act_id_                varchar(255)            null,
    super_process_instance_id_ varchar(64)             null,
    delete_reason_             varchar(4000)           null,
    tenant_id_                 varchar(255) default '' null,
    name_                      varchar(255)            null,
    callback_id_               varchar(255)            null,
    callback_type_             varchar(255)            null,
    constraint proc_inst_id_
        unique (proc_inst_id_)
)
    comment '历史的流程实例' collate = utf8_bin;

create index act_idx_hi_pro_inst_end
    on act_hi_procinst (end_time_);

create index act_idx_hi_pro_i_buskey
    on act_hi_procinst (business_key_);

create table act_hi_taskinst
(
    id_                  varchar(64)             not null
        primary key,
    rev_                 int          default 1  null,
    proc_def_id_         varchar(64)             null,
    task_def_id_         varchar(64)             null,
    task_def_key_        varchar(255)            null,
    proc_inst_id_        varchar(64)             null,
    execution_id_        varchar(64)             null,
    scope_id_            varchar(255)            null,
    sub_scope_id_        varchar(255)            null,
    scope_type_          varchar(255)            null,
    scope_definition_id_ varchar(255)            null,
    name_                varchar(255)            null,
    parent_task_id_      varchar(64)             null,
    description_         varchar(4000)           null,
    owner_               varchar(255)            null,
    assignee_            varchar(255)            null,
    start_time_          datetime(3)             not null,
    claim_time_          datetime(3)             null,
    end_time_            datetime(3)             null,
    duration_            bigint                  null,
    delete_reason_       varchar(4000)           null,
    priority_            int                     null,
    due_date_            datetime(3)             null,
    form_key_            varchar(255)            null,
    category_            varchar(255)            null,
    tenant_id_           varchar(255) default '' null,
    last_updated_time_   datetime(3)             null
)
    comment '历史的任务实例' collate = utf8_bin;

create index act_idx_hi_task_inst_procinst
    on act_hi_taskinst (proc_inst_id_);

create index act_idx_hi_task_scope
    on act_hi_taskinst (scope_id_, scope_type_);

create index act_idx_hi_task_scope_def
    on act_hi_taskinst (scope_definition_id_, scope_type_);

create index act_idx_hi_task_sub_scope
    on act_hi_taskinst (sub_scope_id_, scope_type_);

create table act_hi_tsk_log
(
    id_                  bigint auto_increment
        primary key,
    type_                varchar(64)                               null,
    task_id_             varchar(64)                               not null,
    time_stamp_          timestamp(3) default current_timestamp(3) not null on update current_timestamp(3),
    user_id_             varchar(255)                              null,
    data_                varchar(4000)                             null,
    execution_id_        varchar(64)                               null,
    proc_inst_id_        varchar(64)                               null,
    proc_def_id_         varchar(64)                               null,
    scope_id_            varchar(255)                              null,
    scope_definition_id_ varchar(255)                              null,
    sub_scope_id_        varchar(255)                              null,
    scope_type_          varchar(255)                              null,
    tenant_id_           varchar(255) default ''                   null
)
    collate = utf8_bin;

create table act_hi_varinst
(
    id_                varchar(64)   not null
        primary key,
    rev_               int default 1 null,
    proc_inst_id_      varchar(64)   null,
    execution_id_      varchar(64)   null,
    task_id_           varchar(64)   null,
    name_              varchar(255)  not null,
    var_type_          varchar(100)  null,
    scope_id_          varchar(255)  null,
    sub_scope_id_      varchar(255)  null,
    scope_type_        varchar(255)  null,
    bytearray_id_      varchar(64)   null,
    double_            double        null,
    long_              bigint        null,
    text_              varchar(4000) null,
    text2_             varchar(4000) null,
    create_time_       datetime(3)   null,
    last_updated_time_ datetime(3)   null
)
    comment '历史的流程运行中的变量信息' collate = utf8_bin;

create index act_idx_hi_procvar_exe
    on act_hi_varinst (execution_id_);

create index act_idx_hi_procvar_name_type
    on act_hi_varinst (name_, var_type_);

create index act_idx_hi_procvar_proc_inst
    on act_hi_varinst (proc_inst_id_);

create index act_idx_hi_procvar_task_id
    on act_hi_varinst (task_id_);

create index act_idx_hi_var_scope_id_type
    on act_hi_varinst (scope_id_, scope_type_);

create index act_idx_hi_var_sub_id_type
    on act_hi_varinst (sub_scope_id_, scope_type_);

create table act_id_bytearray
(
    id_    varchar(64)  not null
        primary key,
    rev_   int          null,
    name_  varchar(255) null,
    bytes_ longblob     null
)
    comment '二进制数据表' collate = utf8_bin;

create table act_id_group
(
    id_   varchar(64)  not null
        primary key,
    rev_  int          null,
    name_ varchar(255) null,
    type_ varchar(255) null
)
    comment '用户组信息表' collate = utf8_bin;

create table act_id_info
(
    id_        varchar(64)  not null
        primary key,
    rev_       int          null,
    user_id_   varchar(64)  null,
    type_      varchar(64)  null,
    key_       varchar(255) null,
    value_     varchar(255) null,
    password_  longblob     null,
    parent_id_ varchar(255) null
)
    comment '用户信息详情表' collate = utf8_bin;

create table act_id_priv
(
    id_   varchar(64)  not null
        primary key,
    name_ varchar(255) not null,
    constraint act_uniq_priv_name
        unique (name_)
)
    comment '权限表' collate = utf8_bin;

create table act_id_priv_mapping
(
    id_       varchar(64)  not null
        primary key,
    priv_id_  varchar(64)  not null,
    user_id_  varchar(255) null,
    group_id_ varchar(255) null,
    constraint act_fk_priv_mapping
        foreign key (priv_id_) references act_id_priv (id_)
)
    comment '用户或组权限关系表' collate = utf8_bin;

create index act_idx_priv_group
    on act_id_priv_mapping (group_id_);

create index act_idx_priv_user
    on act_id_priv_mapping (user_id_);

create table act_id_property
(
    name_  varchar(64)  not null
        primary key,
    value_ varchar(300) null,
    rev_   int          null
)
    comment '属性表' collate = utf8_bin;

create table act_id_token
(
    id_          varchar(64)                               not null
        primary key,
    rev_         int                                       null,
    token_value_ varchar(255)                              null,
    token_date_  timestamp(3) default current_timestamp(3) not null on update current_timestamp(3),
    ip_address_  varchar(255)                              null,
    user_agent_  varchar(255)                              null,
    user_id_     varchar(255)                              null,
    token_data_  varchar(2000)                             null
)
    comment '系统登录日志表' collate = utf8_bin;

create table act_id_user
(
    id_           varchar(64)             not null
        primary key,
    rev_          int                     null,
    first_        varchar(255)            null,
    last_         varchar(255)            null,
    email_        varchar(255)            null,
    pwd_          varchar(255)            null,
    picture_id_   varchar(64)             null,
    tenant_id_    varchar(255) default '' null,
    display_name_ varchar(255) default '' null
)
    comment '用户表' collate = utf8_bin;

create table act_id_membership
(
    user_id_  varchar(64) not null,
    group_id_ varchar(64) not null,
    primary key (user_id_, group_id_),
    constraint act_fk_memb_group
        foreign key (group_id_) references act_id_group (id_),
    constraint act_fk_memb_user
        foreign key (user_id_) references act_id_user (id_)
)
    comment '人与组关系表' collate = utf8_bin;

create table act_re_deployment
(
    id_                   varchar(64)             not null
        primary key,
    name_                 varchar(255)            null,
    category_             varchar(255)            null,
    key_                  varchar(255)            null,
    tenant_id_            varchar(255) default '' null,
    deploy_time_          timestamp(3)            null,
    derived_from_         varchar(64)             null,
    derived_from_root_    varchar(64)             null,
    engine_version_       varchar(255)            null,
    parent_deployment_id_ varchar(255)            null
)
    comment '部署单元信息(流程定义)' collate = utf8_bin;

create table act_ge_bytearray
(
    id_            varchar(64)  not null
        primary key,
    rev_           int          null,
    name_          varchar(255) null,
    deployment_id_ varchar(64)  null,
    bytes_         longblob     null,
    generated_     tinyint      null,
    constraint act_fk_bytearr_depl
        foreign key (deployment_id_) references act_re_deployment (id_)
)
    comment '通用的流程定义和流程资源' collate = utf8_bin;

create table act_re_model
(
    id_                           varchar(64)             not null
        primary key,
    rev_                          int                     null,
    name_                         varchar(255)            null,
    key_                          varchar(255)            null,
    category_                     varchar(255)            null,
    create_time_                  timestamp(3)            null,
    last_update_time_             timestamp(3)            null,
    version_                      int                     null,
    meta_info_                    varchar(4000)           null,
    deployment_id_                varchar(64)             null,
    editor_source_value_id_       varchar(64)             null,
    editor_source_extra_value_id_ varchar(64)             null,
    tenant_id_                    varchar(255) default '' null,
    constraint act_fk_model_deployment
        foreign key (deployment_id_) references act_re_deployment (id_),
    constraint act_fk_model_source
        foreign key (editor_source_value_id_) references act_ge_bytearray (id_),
    constraint act_fk_model_source_extra
        foreign key (editor_source_extra_value_id_) references act_ge_bytearray (id_)
)
    comment '模型信息(流程定义)' collate = utf8_bin;

create table act_re_procdef
(
    id_                     varchar(64)             not null
        primary key,
    rev_                    int                     null,
    category_               varchar(255)            null,
    name_                   varchar(255)            null,
    key_                    varchar(255)            not null,
    version_                int                     not null,
    deployment_id_          varchar(64)             null,
    resource_name_          varchar(4000)           null,
    dgrm_resource_name_     varchar(4000)           null,
    description_            varchar(4000)           null,
    has_start_form_key_     tinyint                 null,
    has_graphical_notation_ tinyint                 null,
    suspension_state_       int                     null,
    tenant_id_              varchar(255) default '' null,
    engine_version_         varchar(255)            null,
    derived_from_           varchar(64)             null,
    derived_from_root_      varchar(64)             null,
    derived_version_        int          default 0  not null,
    constraint act_uniq_procdef
        unique (key_, version_, derived_version_, tenant_id_)
)
    comment '已部署的流程定义(流程定义)' collate = utf8_bin;

create table act_procdef_info
(
    id_           varchar(64) not null
        primary key,
    proc_def_id_  varchar(64) not null,
    rev_          int         null,
    info_json_id_ varchar(64) null,
    constraint act_uniq_info_procdef
        unique (proc_def_id_),
    constraint act_fk_info_json_ba
        foreign key (info_json_id_) references act_ge_bytearray (id_),
    constraint act_fk_info_procdef
        foreign key (proc_def_id_) references act_re_procdef (id_)
)
    comment '流程定义信息' collate = utf8_bin;

create index act_idx_info_procdef
    on act_procdef_info (proc_def_id_);

create table act_ru_actinst
(
    id_                varchar(64)             not null
        primary key,
    rev_               int          default 1  null,
    proc_def_id_       varchar(64)             not null,
    proc_inst_id_      varchar(64)             not null,
    execution_id_      varchar(64)             not null,
    act_id_            varchar(255)            not null,
    task_id_           varchar(64)             null,
    call_proc_inst_id_ varchar(64)             null,
    act_name_          varchar(255)            null,
    act_type_          varchar(255)            not null,
    assignee_          varchar(255)            null,
    start_time_        datetime(3)             not null,
    end_time_          datetime(3)             null,
    duration_          bigint                  null,
    delete_reason_     varchar(4000)           null,
    tenant_id_         varchar(255) default '' null
)
    collate = utf8_bin;

create index act_idx_ru_acti_end
    on act_ru_actinst (end_time_);

create index act_idx_ru_acti_exec
    on act_ru_actinst (execution_id_);

create index act_idx_ru_acti_exec_act
    on act_ru_actinst (execution_id_, act_id_);

create index act_idx_ru_acti_proc
    on act_ru_actinst (proc_inst_id_);

create index act_idx_ru_acti_proc_act
    on act_ru_actinst (proc_inst_id_, act_id_);

create index act_idx_ru_acti_start
    on act_ru_actinst (start_time_);

create table act_ru_entitylink
(
    id_                      varchar(64)  not null
        primary key,
    rev_                     int          null,
    create_time_             datetime(3)  null,
    link_type_               varchar(255) null,
    scope_id_                varchar(255) null,
    scope_type_              varchar(255) null,
    scope_definition_id_     varchar(255) null,
    ref_scope_id_            varchar(255) null,
    ref_scope_type_          varchar(255) null,
    ref_scope_definition_id_ varchar(255) null,
    hierarchy_type_          varchar(255) null
)
    collate = utf8_bin;

create index act_idx_ent_lnk_scope
    on act_ru_entitylink (scope_id_, scope_type_, link_type_);

create index act_idx_ent_lnk_scope_def
    on act_ru_entitylink (scope_definition_id_, scope_type_, link_type_);

create table act_ru_execution
(
    id_                   varchar(64)             not null
        primary key,
    rev_                  int                     null,
    proc_inst_id_         varchar(64)             null,
    business_key_         varchar(255)            null,
    parent_id_            varchar(64)             null,
    proc_def_id_          varchar(64)             null,
    super_exec_           varchar(64)             null,
    root_proc_inst_id_    varchar(64)             null,
    act_id_               varchar(255)            null,
    is_active_            tinyint                 null,
    is_concurrent_        tinyint                 null,
    is_scope_             tinyint                 null,
    is_event_scope_       tinyint                 null,
    is_mi_root_           tinyint                 null,
    suspension_state_     int                     null,
    cached_ent_state_     int                     null,
    tenant_id_            varchar(255) default '' null,
    name_                 varchar(255)            null,
    start_act_id_         varchar(255)            null,
    start_time_           datetime(3)             null,
    start_user_id_        varchar(255)            null,
    lock_time_            timestamp(3)            null,
    is_count_enabled_     tinyint                 null,
    evt_subscr_count_     int                     null,
    task_count_           int                     null,
    job_count_            int                     null,
    timer_job_count_      int                     null,
    susp_job_count_       int                     null,
    deadletter_job_count_ int                     null,
    var_count_            int                     null,
    id_link_count_        int                     null,
    callback_id_          varchar(255)            null,
    callback_type_        varchar(255)            null,
    constraint act_fk_exe_parent
        foreign key (parent_id_) references act_ru_execution (id_)
            on delete cascade,
    constraint act_fk_exe_procdef
        foreign key (proc_def_id_) references act_re_procdef (id_),
    constraint act_fk_exe_procinst
        foreign key (proc_inst_id_) references act_ru_execution (id_)
            on update cascade on delete cascade,
    constraint act_fk_exe_super
        foreign key (super_exec_) references act_ru_execution (id_)
            on delete cascade
)
    comment '运行时流程执行实例' collate = utf8_bin;

create table act_ru_deadletter_job
(
    id_                  varchar(64)             not null
        primary key,
    rev_                 int                     null,
    type_                varchar(255)            not null,
    exclusive_           tinyint(1)              null,
    execution_id_        varchar(64)             null,
    process_instance_id_ varchar(64)             null,
    proc_def_id_         varchar(64)             null,
    scope_id_            varchar(255)            null,
    sub_scope_id_        varchar(255)            null,
    scope_type_          varchar(255)            null,
    scope_definition_id_ varchar(255)            null,
    exception_stack_id_  varchar(64)             null,
    exception_msg_       varchar(4000)           null,
    duedate_             timestamp(3)            null,
    repeat_              varchar(255)            null,
    handler_type_        varchar(255)            null,
    handler_cfg_         varchar(4000)           null,
    custom_values_id_    varchar(64)             null,
    create_time_         timestamp(3)            null,
    tenant_id_           varchar(255) default '' null,
    element_id_          varchar(255)            null,
    element_name_        varchar(255)            null,
    constraint act_fk_deadletter_job_custom_values
        foreign key (custom_values_id_) references act_ge_bytearray (id_),
    constraint act_fk_deadletter_job_exception
        foreign key (exception_stack_id_) references act_ge_bytearray (id_),
    constraint act_fk_deadletter_job_execution
        foreign key (execution_id_) references act_ru_execution (id_),
    constraint act_fk_deadletter_job_process_instance
        foreign key (process_instance_id_) references act_ru_execution (id_),
    constraint act_fk_deadletter_job_proc_def
        foreign key (proc_def_id_) references act_re_procdef (id_)
)
    comment '正在运行的任务表(运行实例)' collate = utf8_bin;

create index act_idx_deadletter_job_custom_values_id
    on act_ru_deadletter_job (custom_values_id_);

create index act_idx_deadletter_job_exception_stack_id
    on act_ru_deadletter_job (exception_stack_id_);

create index act_idx_djob_scope
    on act_ru_deadletter_job (scope_id_, scope_type_);

create index act_idx_djob_scope_def
    on act_ru_deadletter_job (scope_definition_id_, scope_type_);

create index act_idx_djob_sub_scope
    on act_ru_deadletter_job (sub_scope_id_, scope_type_);

create table act_ru_event_subscr
(
    id_                  varchar(64)                               not null
        primary key,
    rev_                 int                                       null,
    event_type_          varchar(255)                              not null,
    event_name_          varchar(255)                              null,
    execution_id_        varchar(64)                               null,
    proc_inst_id_        varchar(64)                               null,
    activity_id_         varchar(64)                               null,
    configuration_       varchar(255)                              null,
    created_             timestamp(3) default current_timestamp(3) not null,
    proc_def_id_         varchar(64)                               null,
    tenant_id_           varchar(255) default ''                   null,
    sub_scope_id_        varchar(64)                               null,
    scope_id_            varchar(64)                               null,
    scope_definition_id_ varchar(64)                               null,
    scope_type_          varchar(64)                               null,
    constraint act_fk_event_exec
        foreign key (execution_id_) references act_ru_execution (id_)
)
    comment '运行时事件' collate = utf8_bin;

create index act_idx_event_subscr_config_
    on act_ru_event_subscr (configuration_);

create index act_idc_exec_root
    on act_ru_execution (root_proc_inst_id_);

create index act_idx_exec_buskey
    on act_ru_execution (business_key_);

create table act_ru_history_job
(
    id_                 varchar(64)             not null
        primary key,
    rev_                int                     null,
    lock_exp_time_      timestamp(3)            null,
    lock_owner_         varchar(255)            null,
    retries_            int                     null,
    exception_stack_id_ varchar(64)             null,
    exception_msg_      varchar(4000)           null,
    handler_type_       varchar(255)            null,
    handler_cfg_        varchar(4000)           null,
    custom_values_id_   varchar(64)             null,
    adv_handler_cfg_id_ varchar(64)             null,
    create_time_        timestamp(3)            null,
    tenant_id_          varchar(255) default '' null,
    scope_type_         varchar(255)            null
)
    comment '运行时历史作业表' collate = utf8_bin;

create table act_ru_job
(
    id_                  varchar(64)             not null
        primary key,
    rev_                 int                     null,
    type_                varchar(255)            not null,
    lock_exp_time_       timestamp(3)            null,
    lock_owner_          varchar(255)            null,
    exclusive_           tinyint(1)              null,
    execution_id_        varchar(64)             null,
    process_instance_id_ varchar(64)             null,
    proc_def_id_         varchar(64)             null,
    scope_id_            varchar(255)            null,
    sub_scope_id_        varchar(255)            null,
    scope_type_          varchar(255)            null,
    scope_definition_id_ varchar(255)            null,
    retries_             int                     null,
    exception_stack_id_  varchar(64)             null,
    exception_msg_       varchar(4000)           null,
    duedate_             timestamp(3)            null,
    repeat_              varchar(255)            null,
    handler_type_        varchar(255)            null,
    handler_cfg_         varchar(4000)           null,
    custom_values_id_    varchar(64)             null,
    create_time_         timestamp(3)            null,
    tenant_id_           varchar(255) default '' null,
    element_id_          varchar(255)            null,
    element_name_        varchar(255)            null,
    constraint act_fk_job_custom_values
        foreign key (custom_values_id_) references act_ge_bytearray (id_),
    constraint act_fk_job_exception
        foreign key (exception_stack_id_) references act_ge_bytearray (id_),
    constraint act_fk_job_execution
        foreign key (execution_id_) references act_ru_execution (id_),
    constraint act_fk_job_process_instance
        foreign key (process_instance_id_) references act_ru_execution (id_),
    constraint act_fk_job_proc_def
        foreign key (proc_def_id_) references act_re_procdef (id_)
)
    comment '运行时作业表' collate = utf8_bin;

create index act_idx_job_custom_values_id
    on act_ru_job (custom_values_id_);

create index act_idx_job_exception_stack_id
    on act_ru_job (exception_stack_id_);

create index act_idx_job_scope
    on act_ru_job (scope_id_, scope_type_);

create index act_idx_job_scope_def
    on act_ru_job (scope_definition_id_, scope_type_);

create index act_idx_job_sub_scope
    on act_ru_job (sub_scope_id_, scope_type_);

create table act_ru_suspended_job
(
    id_                  varchar(64)             not null
        primary key,
    rev_                 int                     null,
    type_                varchar(255)            not null,
    exclusive_           tinyint(1)              null,
    execution_id_        varchar(64)             null,
    process_instance_id_ varchar(64)             null,
    proc_def_id_         varchar(64)             null,
    scope_id_            varchar(255)            null,
    sub_scope_id_        varchar(255)            null,
    scope_type_          varchar(255)            null,
    scope_definition_id_ varchar(255)            null,
    retries_             int                     null,
    exception_stack_id_  varchar(64)             null,
    exception_msg_       varchar(4000)           null,
    duedate_             timestamp(3)            null,
    repeat_              varchar(255)            null,
    handler_type_        varchar(255)            null,
    handler_cfg_         varchar(4000)           null,
    custom_values_id_    varchar(64)             null,
    create_time_         timestamp(3)            null,
    tenant_id_           varchar(255) default '' null,
    element_id_          varchar(255)            null,
    element_name_        varchar(255)            null,
    constraint act_fk_suspended_job_custom_values
        foreign key (custom_values_id_) references act_ge_bytearray (id_),
    constraint act_fk_suspended_job_exception
        foreign key (exception_stack_id_) references act_ge_bytearray (id_),
    constraint act_fk_suspended_job_execution
        foreign key (execution_id_) references act_ru_execution (id_),
    constraint act_fk_suspended_job_process_instance
        foreign key (process_instance_id_) references act_ru_execution (id_),
    constraint act_fk_suspended_job_proc_def
        foreign key (proc_def_id_) references act_re_procdef (id_)
)
    comment '暂停作业表' collate = utf8_bin;

create index act_idx_sjob_scope
    on act_ru_suspended_job (scope_id_, scope_type_);

create index act_idx_sjob_scope_def
    on act_ru_suspended_job (scope_definition_id_, scope_type_);

create index act_idx_sjob_sub_scope
    on act_ru_suspended_job (sub_scope_id_, scope_type_);

create index act_idx_suspended_job_custom_values_id
    on act_ru_suspended_job (custom_values_id_);

create index act_idx_suspended_job_exception_stack_id
    on act_ru_suspended_job (exception_stack_id_);

create table act_ru_task
(
    id_                  varchar(64)             not null
        primary key,
    rev_                 int                     null,
    execution_id_        varchar(64)             null,
    proc_inst_id_        varchar(64)             null,
    proc_def_id_         varchar(64)             null,
    task_def_id_         varchar(64)             null,
    scope_id_            varchar(255)            null,
    sub_scope_id_        varchar(255)            null,
    scope_type_          varchar(255)            null,
    scope_definition_id_ varchar(255)            null,
    name_                varchar(255)            null,
    parent_task_id_      varchar(64)             null,
    description_         varchar(4000)           null,
    task_def_key_        varchar(255)            null,
    owner_               varchar(255)            null,
    assignee_            varchar(255)            null,
    delegation_          varchar(64)             null,
    priority_            int                     null,
    create_time_         timestamp(3)            null,
    due_date_            datetime(3)             null,
    category_            varchar(255)            null,
    suspension_state_    int                     null,
    tenant_id_           varchar(255) default '' null,
    form_key_            varchar(255)            null,
    claim_time_          datetime(3)             null,
    is_count_enabled_    tinyint                 null,
    var_count_           int                     null,
    id_link_count_       int                     null,
    sub_task_count_      int                     null,
    constraint act_fk_task_exe
        foreign key (execution_id_) references act_ru_execution (id_),
    constraint act_fk_task_procdef
        foreign key (proc_def_id_) references act_re_procdef (id_),
    constraint act_fk_task_procinst
        foreign key (proc_inst_id_) references act_ru_execution (id_)
)
    comment '运行时任务表' collate = utf8_bin;

create table act_ru_identitylink
(
    id_                  varchar(64)  not null
        primary key,
    rev_                 int          null,
    group_id_            varchar(255) null,
    type_                varchar(255) null,
    user_id_             varchar(255) null,
    task_id_             varchar(64)  null,
    proc_inst_id_        varchar(64)  null,
    proc_def_id_         varchar(64)  null,
    scope_id_            varchar(255) null,
    scope_type_          varchar(255) null,
    scope_definition_id_ varchar(255) null,
    constraint act_fk_athrz_procedef
        foreign key (proc_def_id_) references act_re_procdef (id_),
    constraint act_fk_idl_procinst
        foreign key (proc_inst_id_) references act_ru_execution (id_),
    constraint act_fk_tskass_task
        foreign key (task_id_) references act_ru_task (id_)
)
    comment '运行时用户关系信息' collate = utf8_bin;

create index act_idx_athrz_procedef
    on act_ru_identitylink (proc_def_id_);

create index act_idx_ident_lnk_group
    on act_ru_identitylink (group_id_);

create index act_idx_ident_lnk_scope
    on act_ru_identitylink (scope_id_, scope_type_);

create index act_idx_ident_lnk_scope_def
    on act_ru_identitylink (scope_definition_id_, scope_type_);

create index act_idx_ident_lnk_user
    on act_ru_identitylink (user_id_);

create index act_idx_task_create
    on act_ru_task (create_time_);

create index act_idx_task_scope
    on act_ru_task (scope_id_, scope_type_);

create index act_idx_task_scope_def
    on act_ru_task (scope_definition_id_, scope_type_);

create index act_idx_task_sub_scope
    on act_ru_task (sub_scope_id_, scope_type_);

create table act_ru_timer_job
(
    id_                  varchar(64)             not null
        primary key,
    rev_                 int                     null,
    type_                varchar(255)            not null,
    lock_exp_time_       timestamp(3)            null,
    lock_owner_          varchar(255)            null,
    exclusive_           tinyint(1)              null,
    execution_id_        varchar(64)             null,
    process_instance_id_ varchar(64)             null,
    proc_def_id_         varchar(64)             null,
    scope_id_            varchar(255)            null,
    sub_scope_id_        varchar(255)            null,
    scope_type_          varchar(255)            null,
    scope_definition_id_ varchar(255)            null,
    retries_             int                     null,
    exception_stack_id_  varchar(64)             null,
    exception_msg_       varchar(4000)           null,
    duedate_             timestamp(3)            null,
    repeat_              varchar(255)            null,
    handler_type_        varchar(255)            null,
    handler_cfg_         varchar(4000)           null,
    custom_values_id_    varchar(64)             null,
    create_time_         timestamp(3)            null,
    tenant_id_           varchar(255) default '' null,
    element_id_          varchar(255)            null,
    element_name_        varchar(255)            null,
    constraint act_fk_timer_job_custom_values
        foreign key (custom_values_id_) references act_ge_bytearray (id_),
    constraint act_fk_timer_job_exception
        foreign key (exception_stack_id_) references act_ge_bytearray (id_),
    constraint act_fk_timer_job_execution
        foreign key (execution_id_) references act_ru_execution (id_),
    constraint act_fk_timer_job_process_instance
        foreign key (process_instance_id_) references act_ru_execution (id_),
    constraint act_fk_timer_job_proc_def
        foreign key (proc_def_id_) references act_re_procdef (id_)
)
    comment '定时作业表' collate = utf8_bin;

create index act_idx_timer_job_custom_values_id
    on act_ru_timer_job (custom_values_id_);

create index act_idx_timer_job_exception_stack_id
    on act_ru_timer_job (exception_stack_id_);

create index act_idx_tjob_scope
    on act_ru_timer_job (scope_id_, scope_type_);

create index act_idx_tjob_scope_def
    on act_ru_timer_job (scope_definition_id_, scope_type_);

create index act_idx_tjob_sub_scope
    on act_ru_timer_job (sub_scope_id_, scope_type_);

create table act_ru_variable
(
    id_           varchar(64)   not null
        primary key,
    rev_          int           null,
    type_         varchar(255)  not null,
    name_         varchar(255)  not null,
    execution_id_ varchar(64)   null,
    proc_inst_id_ varchar(64)   null,
    task_id_      varchar(64)   null,
    scope_id_     varchar(255)  null,
    sub_scope_id_ varchar(255)  null,
    scope_type_   varchar(255)  null,
    bytearray_id_ varchar(64)   null,
    double_       double        null,
    long_         bigint        null,
    text_         varchar(4000) null,
    text2_        varchar(4000) null,
    constraint act_fk_var_bytearray
        foreign key (bytearray_id_) references act_ge_bytearray (id_),
    constraint act_fk_var_exe
        foreign key (execution_id_) references act_ru_execution (id_),
    constraint act_fk_var_procinst
        foreign key (proc_inst_id_) references act_ru_execution (id_)
)
    comment '运行时变量表' collate = utf8_bin;

create index act_idx_ru_var_scope_id_type
    on act_ru_variable (scope_id_, scope_type_);

create index act_idx_ru_var_sub_id_type
    on act_ru_variable (sub_scope_id_, scope_type_);

create index act_idx_variable_task_id
    on act_ru_variable (task_id_);

