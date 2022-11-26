// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, constant_identifier_names, camel_case_types, library_private_types_in_public_api

import 'dart:ffi' as ffi;

/// Hashcat Version 6.2.6 Bindings
///
/// There is a bug currently using the generated bindings. The pointer to a
/// struct passed to Hashcat works and Hashcat updates the values correctly
/// but for some reason, Dart does not see the changes in the struct. I am
/// assuming that it is due to some wrong bindings from the generated bindings.
///
/// These are hand-written bindings, from scratch, that defines the types to
/// communicate between Dart and Hashcat. When updating Hashcat version, check
/// for any changes to the following types and structs.
///
/// Even if some definitions are missing, it should still function correctly.
/// This is because the allocation should be happening in Hashcat. So even if
/// a variable was missing, although you couldn't access it in Dart, should
/// be fine in Hashcat since that memory has been allocated.

/// CONSTS
const MAX_OLD_EVENTS = 10;
const HCBUFSIZ_LARGE = 0x1000000;
const DEVICES_MAX = 128;
const CL_PLATFORMS_MAX = 16;
/// CONSTS END

/// TYPEDEFS
typedef u8 = ffi.Uint8;
typedef u32 = ffi.Uint32;
typedef u64 = ffi.Uint64;
typedef size_t = ffi.Size;  // I hope this is right... https://api.dart.dev/dev/2.17.0-146.0.dev/dart-ffi/Size-class.html
// I am actually pretty sure this is wrong but without knowing each device and which type it chooses this is the best I can do...
typedef time_t = ffi.Long;  // I hope this is right... https://en.wikipedia.org/wiki/C_date_and_time_functions#time_t

// typedef HM_ADAPTER_ADL = ffi.Int;
// class nvmlDevice_st extends ffi.Opaque {}
// typedef nvmlDevice_t = ffi.Pointer<nvmlDevice_st>;
// typedef HM_ADAPTER_NVML = nvmlDevice_t;
// class NvPhysicalGpuHandle extends ffi.Opaque {}
// typedef HM_ADAPTER_NVAPI = NvPhysicalGpuHandle;
// typedef HM_ADAPTER_SYSFS_AMDGPU = ffi.Int;
// typedef HM_ADAPTER_SYSFS_CPU = ffi.Int;
// typedef HM_ADAPTER_IOKIT = ffi.Int;

typedef hc_dynlib_t = ffi.Pointer<ffi.Void>;
// typedef void (*MODULE_INIT) (void *);
typedef MODULE_INIT = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>;


class _cl_platform_id extends ffi.Opaque {}
typedef cl_platform_id = ffi.Pointer<_cl_platform_id>;

typedef cl_ulong = ffi.Uint64;
typedef cl_bitfield = cl_ulong;
typedef cl_device_type = cl_bitfield;

typedef iconv_t = ffi.Pointer<ffi.Void>;

/// PLATFORM SPECIFIC TYPEDEFS
// All but windows taken from c_type.dart from ffi
@ffi.AbiSpecificIntegerMapping({
  ffi.Abi.androidArm: ffi.Uint32(),
  ffi.Abi.androidArm64: ffi.Uint64(),
  ffi.Abi.androidIA32: ffi.Uint32(),
  ffi.Abi.androidX64: ffi.Uint64(),
  ffi.Abi.fuchsiaArm64: ffi.Uint64(),
  ffi.Abi.fuchsiaX64: ffi.Uint64(),
  ffi.Abi.iosArm: ffi.Uint32(),
  ffi.Abi.iosArm64: ffi.Uint64(),
  ffi.Abi.iosX64: ffi.Uint64(),
  ffi.Abi.linuxArm: ffi.Uint32(),
  ffi.Abi.linuxArm64: ffi.Uint64(),
  ffi.Abi.linuxIA32: ffi.Uint32(),
  ffi.Abi.linuxX64: ffi.Uint64(),
  ffi.Abi.linuxRiscv32: ffi.Uint32(),
  ffi.Abi.linuxRiscv64: ffi.Uint64(),
  ffi.Abi.macosArm64: ffi.Uint64(),
  ffi.Abi.macosX64: ffi.Uint64(),
  ffi.Abi.windowsArm64: u32(),
  ffi.Abi.windowsIA32: u32(),
  ffi.Abi.windowsX64: u32(),
})
class _cnt extends ffi.AbiSpecificInteger {
  const _cnt();
}
/// PLATFORM SPECIFIC TYPEDEFS END
/// TYPEDEFS END

/// STRUCTS
class brain_ctx extends ffi.Struct {
  @ffi.Bool()
  external bool support;  // general brain support compiled in (server or client)
  @ffi.Bool()
  external bool enabled;  // brain support required by user request on command line
}
typedef brain_ctx_t = brain_ctx;

class bitmap_ctx extends ffi.Struct {
  // bool enabled;
  @ffi.Bool()
  external bool enabled;

  // u32   bitmap_bits;
  @u32()
  external int bitmap_bits;
  // u32   bitmap_nums;
  @u32()
  external int bitmap_nums;
  // u32   bitmap_size;
  @u32()
  external int bitmap_size;
  // u32   bitmap_mask;
  @u32()
  external int bitmap_mask;
  // u32   bitmap_shift1;
  @u32()
  external int bitmap_shift1;
  // u32   bitmap_shift2;
  @u32()
  external int bitmap_shift2;

  // u32  *bitmap_s1_a;
  external ffi.Pointer<u32> bitmap_s1_a;
  // u32  *bitmap_s1_b;
  external ffi.Pointer<u32> bitmap_s1_b;
  // u32  *bitmap_s1_c;
  external ffi.Pointer<u32> bitmap_s1_c;
  // u32  *bitmap_s1_d;
  external ffi.Pointer<u32> bitmap_s1_d;
  // u32  *bitmap_s2_a;
  external ffi.Pointer<u32> bitmap_s2_a;
  // u32  *bitmap_s2_b;
  external ffi.Pointer<u32> bitmap_s2_b;
  // u32  *bitmap_s2_c;
  external ffi.Pointer<u32> bitmap_s2_c;
  // u32  *bitmap_s2_d;
  external ffi.Pointer<u32> bitmap_s2_d;
}
typedef bitmap_ctx_t = bitmap_ctx;

class combinator_ctx extends ffi.Struct {
  // bool enabled;
  @ffi.Bool()
  external bool enabled;

  // char *dict1;
  external ffi.Pointer<ffi.Char> dict1;
  // char *dict2;
  external ffi.Pointer<ffi.Char> dict2;

  // u32 combs_mode;
  @u32()
  external int combs_mode;
  // u64 combs_cnt;
  @u64()
  external int combs_cnt;
}
typedef combinator_ctx_t = combinator_ctx;

class cpt extends ffi.Struct {
  // u32       cracked;
  @u32()
  external int cracked;
  // time_t    timestamp;
  @time_t()
  external int timestamp;
}
typedef cpt_t = cpt;

class cpt_ctx extends ffi.Struct {
  // bool enabled;
  @ffi.Bool()
  external bool enabled;

  // cpt_t     *cpt_buf;
  external ffi.Pointer<cpt_t> cpt_buf;
  // int        cpt_pos;
  @ffi.Int()
  external int cpt_pos;
  // time_t     cpt_start;
  @time_t()
  external int cpt_start;
  // u64        cpt_total;
  @u64()
  external int cpt_total;
}
typedef cpt_ctx_t = cpt_ctx;

class hc_fp extends ffi.Struct {
  // int         fd;
  @ffi.Int()
  external int fd;

  // FILE       *pfp; // plain fp TODO
  // gzFile      gfp; //  gzip fp TODO
  // unzFile     ufp; //   zip fp TODO
  // xzfile_t   *xfp; //    xz fp TODO

  // int         bom_size;
  @ffi.Int()
  external int bom_size;

  // const char *mode;
  external ffi.Pointer<ffi.Char> mode;
  // const char *path;
  external ffi.Pointer<ffi.Char> path;
}
typedef HCFILE = hc_fp;

class debugfile_ctx extends ffi.Struct {
  // HCFILE  fp;
  external HCFILE fp;

  // bool    enabled;
  @ffi.Bool()
  external bool enabled;

  // char   *filename;
  external ffi.Pointer<ffi.Char> filename;
  // u32     mode;
  @u32()
  external int mode;
}
typedef debugfile_ctx_t = debugfile_ctx;

class dictstat extends ffi.Struct {
  // u64 cnt;
  @u64()
  external int cnt;

  // struct stat stat; TODO

  // char encoding_from[64];
  @ffi.Array<ffi.Char>.multi([64])
  external ffi.Array<ffi.Char> encoding_from;
  // char encoding_to[64];
  @ffi.Array<ffi.Char>.multi([64])
  external ffi.Array<ffi.Char> encoding_to;

  // u8 hash_filename[16];
  @ffi.Array<u8>.multi([16])
  external ffi.Array<u8> hash_filename;
}
typedef dictstat_t = dictstat;

class dictstat_ctx extends ffi.Struct {
  // bool enabled;
  @ffi.Bool()
  external bool enabled;

  // char *filename;
  external ffi.Pointer<ffi.Char> filename;

  // dictstat_t *base;
  external ffi.Pointer<dictstat_t> base;

  // #if defined (_WIN)
  // u32    cnt;
  // #else
  // size_t cnt;
  // #endif
  @_cnt()
  external int cnt;
}
typedef dictstat_ctx_t = dictstat_ctx;

class event_ctx extends ffi.Struct {
  // char   old_buf[MAX_OLD_EVENTS][HCBUFSIZ_LARGE];
  @ffi.Array<ffi.Char>.multi([MAX_OLD_EVENTS, HCBUFSIZ_LARGE])
  external ffi.Array<ffi.Array<ffi.Char>> old_buf;
  // size_t old_len[MAX_OLD_EVENTS];
  @ffi.Array<size_t>.multi([MAX_OLD_EVENTS])
  external ffi.Array<size_t> old_len;
  // int    old_cnt;
  @ffi.Int()
  external int old_cnt;

  // char   msg_buf[HCBUFSIZ_LARGE];
  @ffi.Array<ffi.Char>.multi([HCBUFSIZ_LARGE])
  external ffi.Array<ffi.Char> msg_buf;
  // size_t msg_len;
  @size_t()
  external int msg_len;
  // bool   msg_newline;
  @ffi.Bool()
  external bool msg_newline;

  // size_t prev_len;
  @size_t()
  external int prev_len;

  // hc_thread_mutex_t mux_event; TODO
}
typedef event_ctx_t = event_ctx;

class folder_config extends ffi.Struct {
  // char *cwd;
  external ffi.Pointer<ffi.Char> cwd;
  // char *install_dir;
  external ffi.Pointer<ffi.Char> install_dir;
  // char *profile_dir;
  external ffi.Pointer<ffi.Char> profile_dir;
  // char *cache_dir;
  external ffi.Pointer<ffi.Char> cache_dir;
  // char *session_dir;
  external ffi.Pointer<ffi.Char> session_dir;
  // char *shared_dir;
  external ffi.Pointer<ffi.Char> shared_dir;
  // char *cpath_real;
  external ffi.Pointer<ffi.Char> cpath_real;
}
typedef folder_config_t = folder_config;

class hashcat_user extends ffi.Struct {
  // use this for context specific data
  // see main.c as how this example is used

  // int          outer_threads_cnt;
  @ffi.Int()
  external int outer_threads_cnt;
  // hc_thread_t *outer_threads; TODO
}
typedef hashcat_user_t = hashcat_user;

class hashconfig extends ffi.Struct {
  // char  separator;
  @ffi.Char()
  external int separator;

  // int   hash_mode;
  @ffi.Int()
  external int hash_mode;
  // u32   salt_type;
  @u32()
  external int salt_type;
  // u32   attack_exec;
  @u32()
  external int attack_exec;
  // u32   kern_type;
  @u32()
  external int kern_type;
  // u32   dgst_size;
  @u32()
  external int dgst_size;
  // u32   opti_type;
  @u32()
  external int opti_type;
  // u64   opts_type;
  @u64()
  external int opts_type;
  // u32   dgst_pos0;
  @u32()
  external int dgst_pos0;
  // u32   dgst_pos1;
  @u32()
  external int dgst_pos1;
  // u32   dgst_pos2;
  @u32()
  external int dgst_pos2;
  // u32   dgst_pos3;
  @u32()
  external int dgst_pos3;

  // bool  is_salted;
  @ffi.Bool()
  external bool is_salted;

  // bool  has_pure_kernel;
  @ffi.Bool()
  external bool has_pure_kernel;
  // bool  has_optimized_kernel;
  @ffi.Bool()
  external bool has_optimized_kernel;

  // sizes have to be size_t

  // u64   esalt_size;
  @u64()
  external int esalt_size;
  // u64   hook_extra_param_size;
  @u64()
  external int hook_extra_param_size;
  // u64   hook_salt_size;
  @u64()
  external int hook_salt_size;
  // u64   tmp_size;
  @u64()
  external int tmp_size;
  // u64   hook_size;
  @u64()
  external int hook_size;

  // password length limit

  // u32   pw_min;
  @u32()
  external int pw_min;
  // u32   pw_max;
  @u32()
  external int pw_max;

  // salt length limit (generic hashes)

  // u32   salt_min;
  @u32()
  external int salt_min;
  // u32   salt_max;
  @u32()
  external int salt_max;

  // hash count limit

  // u32   hashes_count_min;
  @u32()
  external int hashes_count_min;
  // u32   hashes_count_max;
  @u32()
  external int hashes_count_max;

  // //  int (*parse_func) (u8 *, u32, hash_t *, struct hashconfig *);
  // external ffi.Pointer<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<u8>, u32, ffi.Pointer<hash_t>, ffi.Pointer<hashconfig>)>> parse_func;

  // const char *st_hash;
  external ffi.Pointer<ffi.Char> st_hash;
  // const char *st_pass;
  external ffi.Pointer<ffi.Char> st_pass;

  // u32         hash_category;
  @u32()
  external int hash_category;
  // const char *hash_name;
  external ffi.Pointer<ffi.Char> hash_name;

  // const char *benchmark_mask;
  external ffi.Pointer<ffi.Char> benchmark_mask;
  // const char *benchmark_charset;
  external ffi.Pointer<ffi.Char> benchmark_charset;

  // u32 kernel_accel_min;
  @u32()
  external int kernel_accel_min;
  // u32 kernel_accel_max;
  @u32()
  external int kernel_accel_max;
  // u32 kernel_loops_min;
  @u32()
  external int kernel_loops_min;
  // u32 kernel_loops_max;
  @u32()
  external int kernel_loops_max;
  // u32 kernel_threads_min;
  @u32()
  external int kernel_threads_min;
  // u32 kernel_threads_max;
  @u32()
  external int kernel_threads_max;

  // u32 forced_outfile_format;
  @u32()
  external int forced_outfile_format;

  // bool dictstat_disable;
  @ffi.Bool()
  external bool dictstat_disable;
  // bool hlfmt_disable;
  @ffi.Bool()
  external bool hlfmt_disable;
  // bool warmup_disable;
  @ffi.Bool()
  external bool warmup_disable;
  // bool outfile_check_disable;
  @ffi.Bool()
  external bool outfile_check_disable;
  // bool outfile_check_nocomp;
  @ffi.Bool()
  external bool outfile_check_nocomp;
  // bool potfile_disable;
  @ffi.Bool()
  external bool potfile_disable;
  // bool potfile_keep_all_hashes;
  @ffi.Bool()
  external bool potfile_keep_all_hashes;
  // bool forced_jit_compile;
  @ffi.Bool()
  external bool forced_jit_compile;

  // u32 pwdump_column;
  @u32()
  external int pwdump_column;
}
typedef hashconfig_t = hashconfig;

class salt extends ffi.Struct {
  // u32 salt_buf[64];
  @ffi.Array<u32>.multi([64])
  external ffi.Array<u32> salt_buf;
  // u32 salt_buf_pc[64];
  @ffi.Array<u32>.multi([64])
  external ffi.Array<u32> salt_buf_pc;

  // u32 salt_len;
  @u32()
  external int salt_len;
  // u32 salt_len_pc;
  @u32()
  external int salt_len_pc;
  // u32 salt_iter;
  @u32()
  external int salt_iter;
  // u32 salt_iter2;
  @u32()
  external int salt_iter2;
  // u32 salt_sign[2];
  @ffi.Array<u32>.multi([2])
  external ffi.Array<u32> salt_sign;
  // u32 salt_repeats;
  @u32()
  external int salt_repeats;

  // u32 orig_pos;
  @u32()
  external int orig_pos;

  // u32 digests_cnt;
  @u32()
  external int digests_cnt;
  // u32 digests_done;
  @u32()
  external int digests_done;

  // u32 digests_offset;
  @u32()
  external int digests_offset;

  // u32 scrypt_N;
  @u32()
  external int scrypt_N;
  // u32 scrypt_r;
  @u32()
  external int scrypt_r;
  // u32 scrypt_p;
  @u32()
  external int scrypt_p;
}
typedef salt_t = salt;

class user extends ffi.Struct {
  // char *user_name;
  external ffi.Pointer<ffi.Char> user_name;
  // u32   user_len;
  @u32()
  external int user_len;
}
typedef user_t = user;

class split extends ffi.Struct {
  // some hashes, like lm, are split. this id point to the other hash of the group
  // int split_group;
  @ffi.Int()
  external int split_group;
  // int split_neighbor;
  @ffi.Int()
  external int split_neighbor;
  // int split_origin;
  @ffi.Int()
  external int split_origin;
}
typedef split_t = split;

class hashinfo extends ffi.Struct {
  // user_t  *user;
  external ffi.Pointer<user_t> user;
  // char    *orighash;
  external ffi.Pointer<ffi.Char> orighash;
  // split_t *split;
  external ffi.Pointer<split_t> split;
}
typedef hashinfo_t = hashinfo;

class hash extends ffi.Struct {
  // void       *digest;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> digest;
  // salt_t     *salt;
  external ffi.Pointer<salt_t> salt;
  // void       *esalt;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> esalt;
  // void       *hook_salt; // additional salt info only used by the hook (host)
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> hook_salt;
  // int         cracked;
  @ffi.Int()
  external int cracked;
  // int         cracked_pot;
  @ffi.Int()
  external int cracked_pot;
  // int         cracked_zero;
  @ffi.Int()
  external int cracked_zero;
  // hashinfo_t *hash_info;
  external ffi.Pointer<hashinfo_t> hash_info;
  // char       *pw_buf;
  external ffi.Pointer<ffi.Char> pw_buf;
  // int         pw_len;
  @ffi.Int()
  external int pw_len;
  // u64         orig_line_pos;
  @u64()
  external int orig_line_pos;
}
typedef hash_t = hash;

class hashes extends ffi.Struct {
  // const char  *hashfile;
  external ffi.Pointer<ffi.Char> hashfile;

  // u32          hashlist_mode;
  @u32()
  external int hashlist_mode;
  // u32          hashlist_format;
  @u32()
  external int hashlist_format;

  // u32          digests_cnt;
  @u32()
  external int digests_cnt;
  // u32          digests_done;
  @u32()
  external int digests_done;
  // u32          digests_done_pot;
  @u32()
  external int digests_done_pot;
  // u32          digests_done_zero;
  @u32()
  external int digests_done_zero;
  // u32          digests_done_new;
  @u32()
  external int digests_done_new;
  // u32          digests_saved;
  @u32()
  external int digests_saved;

  // void        *digests_buf;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> digests_buf;
  // u32         *digests_shown;
  @u32()
  external int digests_shown;

  // u32          salts_cnt;
  @u32()
  external int salts_cnt;
  // u32          salts_done;
  @u32()
  external int salts_done;

  // salt_t      *salts_buf;
  external ffi.Pointer<salt_t> salts_buf;
  // u32         *salts_shown;
  @u32()
  external int salts_shown;

  // void        *esalts_buf;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> esalts_buf;

  // void        *hook_salts_buf;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> hook_salts_buf;

  // u32          hashes_cnt_orig;
  @u32()
  external int hashes_cnt_orig;
  // u32          hashes_cnt;
  @u32()
  external int hashes_cnt;
  // hash_t      *hashes_buf;
  external ffi.Pointer<hash_t> hashes_buf;

  // hashinfo_t **hash_info;
  external ffi.Pointer<ffi.Pointer<hashinfo_t>> hash_info;

  // u8          *out_buf; // allocates [HCBUFSIZ_LARGE];
  @u8()
  external int out_buf;
  // u8          *tmp_buf; // allocates [HCBUFSIZ_LARGE];
  @u8()
  external int tmp_buf;

  // // selftest buffers

  // void        *st_digests_buf;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> st_digests_buf;
  // salt_t      *st_salts_buf;
  external ffi.Pointer<salt_t> st_salts_buf;
  // void        *st_esalts_buf;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> st_esalts_buf;
  // void        *st_hook_salts_buf;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> st_hook_salts_buf;

  // int          parser_token_length_cnt;
  @ffi.Int()
  external int parser_token_length_cnt;
}
typedef hashes_t = hashes;

class hm_attrs extends ffi.Struct {
  // TODO
  // HM_ADAPTER_ADL          adl;
  // external HM_ADAPTER_ADL adl;
  // HM_ADAPTER_NVML         nvml;
  // external HM_ADAPTER_NVML nvml;
  // HM_ADAPTER_NVAPI        nvapi;
  // external HM_ADAPTER_NVAPI nvapi;
  // HM_ADAPTER_SYSFS_AMDGPU sysfs_amdgpu;
  // external HM_ADAPTER_SYSFS_AMDGPU sysfs_amdgpu;
  // HM_ADAPTER_SYSFS_CPU    sysfs_cpu;
  // external HM_ADAPTER_SYSFS_CPU sysfs_cpu;
  // HM_ADAPTER_IOKIT        iokit;
  // external HM_ADAPTER_IOKIT iokit;

  // int od_version;
  @ffi.Int()
  external int od_version;

  // bool buslanes_get_supported;
  @ffi.Bool()
  external bool buslanes_get_supported;
  // bool corespeed_get_supported;
  @ffi.Bool()
  external bool corespeed_get_supported;
  // bool fanspeed_get_supported;
  @ffi.Bool()
  external bool fanspeed_get_supported;
  // bool fanpolicy_get_supported;
  @ffi.Bool()
  external bool fanpolicy_get_supported;
  // bool memoryspeed_get_supported;
  @ffi.Bool()
  external bool memoryspeed_get_supported;
  // bool temperature_get_supported;
  @ffi.Bool()
  external bool temperature_get_supported;
  // bool threshold_shutdown_get_supported;
  @ffi.Bool()
  external bool threshold_shutdown_get_supported;
  // bool threshold_slowdown_get_supported;
  @ffi.Bool()
  external bool threshold_slowdown_get_supported;
  // bool throttle_get_supported;
  @ffi.Bool()
  external bool throttle_get_supported;
  // bool utilization_get_supported;
  @ffi.Bool()
  external bool utilization_get_supported;
}
typedef hm_attrs_t = hm_attrs;

class hwmon_ctx extends ffi.Struct {
  // bool  enabled;
  @ffi.Bool()
  external bool enabled;

  // void *hm_adl;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> hm_adl;
  // void *hm_nvml;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> hm_nvml;
  // void *hm_nvapi;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> hm_nvapi;
  // void *hm_sysfs_amdgpu;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> hm_sysfs_amdgpu;
  // void *hm_sysfs_cpu;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> hm_sysfs_cpu;
  // void *hm_iokit;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> hm_iokit;

  // hm_attrs_t *hm_device;
  external ffi.Pointer<hm_attrs_t> hm_device;
}
typedef hwmon_ctx_t = hwmon_ctx;

class induct_ctx extends ffi.Struct {
  // bool enabled;
  @ffi.Bool()
  external bool enabled;

  // char *root_directory;
  external ffi.Pointer<ffi.Char> root_directory;

  // char **induction_dictionaries;
  external ffi.Pointer<ffi.Pointer<ffi.Char>> induction_dictionaries;
  // int    induction_dictionaries_cnt;
  @ffi.Int()
  external int induction_dictionaries_cnt;
  // int    induction_dictionaries_pos;
  @ffi.Int()
  external int induction_dictionaries_pos;
}
typedef induct_ctx_t = induct_ctx;

class logfile_ctx extends ffi.Struct {
  // bool  enabled;
  @ffi.Bool()
  external bool enabled;

  // char *logfile;
  external ffi.Pointer<ffi.Char> logfile;
  // char *topid;
  external ffi.Pointer<ffi.Char> topid;
  // char *subid;
  external ffi.Pointer<ffi.Char> subid;
}
typedef logfile_ctx_t = logfile_ctx;

class loopback_ctx extends ffi.Struct {
  // HCFILE  fp;
  external HCFILE fp;

  // bool    enabled;
  @ffi.Bool()
  external bool enabled;
  // bool    unused;
  @ffi.Bool()
  external bool unused;

  // char   *filename;
  external ffi.Pointer<ffi.Char> filename;
}
typedef loopback_ctx_t = loopback_ctx;

class S_cs_t extends ffi.Struct {
  // u32 cs_buf[0x100];
  @ffi.Array.multi([0x100])
  external ffi.Array<u32> cs_buf;
  // u32 cs_len;
  @u32()
  external int cs_len;
}
typedef cs_t = S_cs_t;

class S_hcstat_table_t extends ffi.Struct {
  // u32 key;
  @u32()
  external int key;
  // u64 val;
  @u64()
  external int val;
}
typedef hcstat_table_t = S_hcstat_table_t;

class S_mf_t extends ffi.Struct {
  // char mf_buf[0x400];
  @ffi.Array<ffi.Char>.multi([0x400])
  external ffi.Array<ffi.Char> cs_buf;
  // int  mf_len;
  @ffi.Int()
  external int mf_len;
}
typedef mf_t = S_mf_t;

class mask_ctx extends ffi.Struct {
  // bool   enabled;
  @ffi.Bool()
  external bool enabled;

  // cs_t  *mp_sys;
  external ffi.Pointer<cs_t> mp_sys;
  // cs_t  *mp_usr;
  external ffi.Pointer<cs_t> mp_usr;

  // u64    bfs_cnt;
  @u64()
  external int bfs_cnt;

  // cs_t  *css_buf;
  external ffi.Pointer<cs_t> css_buf;
  // u32    css_cnt;
  @u32()
  external int css_cnt;

  // hcstat_table_t *root_table_buf;
  external ffi.Pointer<hcstat_table_t> root_table_buf;
  // hcstat_table_t *markov_table_buf;
  external ffi.Pointer<hcstat_table_t> markov_table_buf;

  // cs_t  *root_css_buf;
  external ffi.Pointer<cs_t> root_css_buf;
  // cs_t  *markov_css_buf;
  external ffi.Pointer<cs_t> markov_css_buf;

  // bool   mask_from_file;
  @ffi.Bool()
  external bool mask_from_file;

  // char **masks;
  external ffi.Pointer<ffi.Pointer<ffi.Char>> masks;
  // u32    masks_pos;
  @u32()
  external int masks_pos;
  // u32    masks_cnt;
  @u32()
  external int masks_cnt;
  // u32    masks_avail;
  @u32()
  external int masks_avail;

  // char  *mask;
  external ffi.Pointer<ffi.Char> mask;

  // mf_t  *mfs;
  external ffi.Pointer<mf_t> mfs;
}
typedef mask_ctx_t = mask_ctx;

class user_options extends ffi.Struct {
  // const char  *hc_bin;
  external ffi.Pointer<ffi.Char> hc_bin;

  // int          hc_argc;
  @ffi.Int()
  external int hc_argc;
  // char       **hc_argv;
  external ffi.Pointer<ffi.Pointer<ffi.Char>> hc_argv;

  // bool         attack_mode_chgd;
  @ffi.Bool()
  external bool attack_mode_chgd;
  // bool         autodetect;
  @ffi.Bool()
  external bool autodetect;
  // #ifdef WITH_BRAIN
  // bool         brain_host_chgd;
  @ffi.Bool()
  external bool brain_host_chgd;
  // bool         brain_port_chgd;
  @ffi.Bool()
  external bool brain_port_chgd;
  // bool         brain_password_chgd;
  @ffi.Bool()
  external bool brain_password_chgd;
  // bool         brain_server_timer_chgd;
  @ffi.Bool()
  external bool brain_server_timer_chgd;
  // #endif
  // bool         hash_mode_chgd;
  @ffi.Bool()
  external bool hash_mode_chgd;
  // bool         hccapx_message_pair_chgd;
  @ffi.Bool()
  external bool hccapx_message_pair_chgd;
  // bool         identify;
  @ffi.Bool()
  external bool identify;
  // bool         increment_max_chgd;
  @ffi.Bool()
  external bool increment_max_chgd;
  // bool         increment_min_chgd;
  @ffi.Bool()
  external bool increment_min_chgd;
  // bool         kernel_accel_chgd;
  @ffi.Bool()
  external bool kernel_accel_chgd;
  // bool         kernel_loops_chgd;
  @ffi.Bool()
  external bool kernel_loops_chgd;
  // bool         kernel_threads_chgd;
  @ffi.Bool()
  external bool kernel_threads_chgd;
  // bool         nonce_error_corrections_chgd;
  @ffi.Bool()
  external bool nonce_error_corrections_chgd;
  // bool         spin_damp_chgd;
  @ffi.Bool()
  external bool spin_damp_chgd;
  // bool         backend_vector_width_chgd;
  @ffi.Bool()
  external bool backend_vector_width_chgd;
  // bool         outfile_format_chgd;
  @ffi.Bool()
  external bool outfile_format_chgd;
  // bool         remove_timer_chgd;
  @ffi.Bool()
  external bool remove_timer_chgd;
  // bool         rp_gen_seed_chgd;
  @ffi.Bool()
  external bool rp_gen_seed_chgd;
  // bool         runtime_chgd;
  @ffi.Bool()
  external bool runtime_chgd;
  // bool         segment_size_chgd;
  @ffi.Bool()
  external bool segment_size_chgd;
  // bool         workload_profile_chgd;
  @ffi.Bool()
  external bool workload_profile_chgd;
  // bool         skip_chgd;
  @ffi.Bool()
  external bool skip_chgd;
  // bool         limit_chgd;
  @ffi.Bool()
  external bool limit_chgd;
  // bool         scrypt_tmto_chgd;
  @ffi.Bool()
  external bool scrypt_tmto_chgd;
  // bool         separator_chgd;
  @ffi.Bool()
  external bool separator_chgd;

  // bool         advice_disable;
  @ffi.Bool()
  external bool advice_disable;
  // bool         benchmark;
  @ffi.Bool()
  external bool benchmark;
  // bool         benchmark_all;
  @ffi.Bool()
  external bool benchmark_all;
  // #ifdef WITH_BRAIN
  // bool         brain_client;
  @ffi.Bool()
  external bool brain_client;
  // bool         brain_server;
  @ffi.Bool()
  external bool brain_server;
  // #endif
  // bool         force;
  @ffi.Bool()
  external bool force;
  // bool         deprecated_check_disable;
  @ffi.Bool()
  external bool deprecated_check_disable;
  // bool         hwmon_disable;
  @ffi.Bool()
  external bool hwmon_disable;
  // bool         hash_info;
  @ffi.Bool()
  external bool hash_info;
  // bool         hex_charset;
  @ffi.Bool()
  external bool hex_charset;
  // bool         hex_salt;
  @ffi.Bool()
  external bool hex_salt;
  // bool         hex_wordlist;
  @ffi.Bool()
  external bool hex_wordlist;
  // bool         increment;
  @ffi.Bool()
  external bool increment;
  // bool         keep_guessing;
  @ffi.Bool()
  external bool keep_guessing;
  // bool         keyspace;
  @ffi.Bool()
  external bool keyspace;
  // bool         left;
  @ffi.Bool()
  external bool left;
  // bool         logfile_disable;
  @ffi.Bool()
  external bool logfile_disable;
  // bool         loopback;
  @ffi.Bool()
  external bool loopback;
  // bool         machine_readable;
  @ffi.Bool()
  external bool machine_readable;
  // bool         markov_classic;
  @ffi.Bool()
  external bool markov_classic;
  // bool         markov_disable;
  @ffi.Bool()
  external bool markov_disable;
  // bool         markov_inverse;
  @ffi.Bool()
  external bool markov_inverse;
  // bool         backend_ignore_cuda;
  @ffi.Bool()
  external bool backend_ignore_cuda;
  // bool         backend_ignore_hip;
  @ffi.Bool()
  external bool backend_ignore_hip;
  // bool         backend_ignore_metal;
  @ffi.Bool()
  external bool backend_ignore_metal;
  // bool         backend_ignore_opencl;
  @ffi.Bool()
  external bool backend_ignore_opencl;
  // bool         optimized_kernel_enable;
  @ffi.Bool()
  external bool optimized_kernel_enable;
  // bool         multiply_accel_disable;
  @ffi.Bool()
  external bool multiply_accel_disable;
  // bool         outfile_autohex;
  @ffi.Bool()
  external bool outfile_autohex;
  // bool         potfile_disable;
  @ffi.Bool()
  external bool potfile_disable;
  // bool         progress_only;
  @ffi.Bool()
  external bool progress_only;
  // bool         quiet;
  @ffi.Bool()
  external bool quiet;
  // bool         remove;
  @ffi.Bool()
  external bool remove;
  // bool         restore;
  @ffi.Bool()
  external bool restore;
  // bool         restore_disable;
  @ffi.Bool()
  external bool restore_disable;
  // bool         self_test_disable;
  @ffi.Bool()
  external bool self_test_disable;
  // bool         show;
  @ffi.Bool()
  external bool show;
  // bool         slow_candidates;
  @ffi.Bool()
  external bool slow_candidates;
  // bool         speed_only;
  @ffi.Bool()
  external bool speed_only;
  // bool         status;
  @ffi.Bool()
  external bool status;
  // bool         status_json;
  @ffi.Bool()
  external bool status_json;
  // bool         stdout_flag;
  @ffi.Bool()
  external bool stdout_flag;
  // bool         stdin_timeout_abort_chgd;
  @ffi.Bool()
  external bool stdin_timeout_abort_chgd;
  // bool         usage;
  @ffi.Bool()
  external bool usage;
  // bool         username;
  @ffi.Bool()
  external bool username;
  // bool         veracrypt_pim_start_chgd;
  @ffi.Bool()
  external bool veracrypt_pim_start_chgd;
  // bool         veracrypt_pim_stop_chgd;
  @ffi.Bool()
  external bool veracrypt_pim_stop_chgd;
  // bool         version;
  @ffi.Bool()
  external bool version;
  // bool         wordlist_autohex_disable;
  @ffi.Bool()
  external bool wordlist_autohex_disable;
  // #ifdef WITH_BRAIN
  // char        *brain_host;
  external ffi.Pointer<ffi.Char> brain_host;
  // char        *brain_password;
  external ffi.Pointer<ffi.Char> brain_password;
  // char        *brain_session_whitelist;
  external ffi.Pointer<ffi.Char> brain_session_whitelist;
  // #endif
  // char        *cpu_affinity;
  external ffi.Pointer<ffi.Char> cpu_affinity;
  // char        *custom_charset_4;
  external ffi.Pointer<ffi.Char> custom_charset_4;
  // char        *debug_file;
  external ffi.Pointer<ffi.Char> debug_file;
  // char        *induction_dir;
  external ffi.Pointer<ffi.Char> induction_dir;
  // char        *keyboard_layout_mapping;
  external ffi.Pointer<ffi.Char> keyboard_layout_mapping;
  // char        *markov_hcstat2;
  external ffi.Pointer<ffi.Char> markov_hcstat2;
  // char        *backend_devices;
  external ffi.Pointer<ffi.Char> backend_devices;
  // char        *opencl_device_types;
  external ffi.Pointer<ffi.Char> opencl_device_types;
  // char        *outfile;
  external ffi.Pointer<ffi.Char> outfile;
  // char        *outfile_check_dir;
  external ffi.Pointer<ffi.Char> outfile_check_dir;
  // char        *potfile_path;
  external ffi.Pointer<ffi.Char> potfile_path;
  // char        *restore_file_path;
  external ffi.Pointer<ffi.Char> restore_file_path;
  // char       **rp_files;
  external ffi.Pointer<ffi.Pointer<ffi.Char>> rp_files;
  // char        *rp_gen_func_sel;
  external ffi.Pointer<ffi.Char> rp_gen_func_sel;
  // char        *separator;
  external ffi.Pointer<ffi.Char> separator;
  // char        *truecrypt_keyfiles;
  external ffi.Pointer<ffi.Char> truecrypt_keyfiles;
  // char        *veracrypt_keyfiles;
  external ffi.Pointer<ffi.Char> veracrypt_keyfiles;
  // const char  *custom_charset_1;
  external ffi.Pointer<ffi.Char> custom_charset_1;
  // const char  *custom_charset_2;
  external ffi.Pointer<ffi.Char> custom_charset_2;
  // const char  *custom_charset_3;
  external ffi.Pointer<ffi.Char> custom_charset_3;
  // const char  *encoding_from;
  external ffi.Pointer<ffi.Char> encoding_from;
  // const char  *encoding_to;
  external ffi.Pointer<ffi.Char> encoding_to;
  // const char  *rule_buf_l;
  external ffi.Pointer<ffi.Char> rule_buf_l;
  // const char  *rule_buf_r;
  external ffi.Pointer<ffi.Char> rule_buf_r;
  // const char  *session;
  external ffi.Pointer<ffi.Char> session;
  // u32          attack_mode;
  @u32()
  external int attack_mode;
  // u32          backend_info;
  @u32()
  external int backend_info;
  // u32          bitmap_max;
  @u32()
  external int bitmap_max;
  // u32          bitmap_min;
  @u32()
  external int bitmap_min;
  // #ifdef WITH_BRAIN
  // u32          brain_server_timer;
  @u32()
  external int brain_server_timer;
  // u32          brain_client_features;
  @u32()
  external int brain_client_features;
  // u32          brain_port;
  @u32()
  external int brain_port;
  // u32          brain_session;
  @u32()
  external int brain_session;
  // u32          brain_attack;
  @u32()
  external int brain_attack;
  // #endif
  // u32          debug_mode;
  @u32()
  external int debug_mode;
  // u32          hwmon_temp_abort;
  @u32()
  external int hwmon_temp_abort;
  // int          hash_mode;
  @u32()
  external int hash_mode;
  // u32          hccapx_message_pair;
  @u32()
  external int hccapx_message_pair;
  // u32          hook_threads;
  @u32()
  external int hook_threads;
  // u32          increment_max;
  @u32()
  external int increment_max;
  // u32          increment_min;
  @u32()
  external int increment_min;
  // u32          kernel_accel;
  @u32()
  external int kernel_accel;
  // u32          kernel_loops;
  @u32()
  external int kernel_loops;
  // u32          kernel_threads;
  @u32()
  external int kernel_threads;
  // u32          markov_threshold;
  @u32()
  external int markov_threshold;
  // u32          nonce_error_corrections;
  @u32()
  external int nonce_error_corrections;
  // u32          spin_damp;
  @u32()
  external int spin_damp;
  // u32          backend_vector_width;
  @u32()
  external int backend_vector_width;
  // u32          outfile_check_timer;
  @u32()
  external int outfile_check_timer;
  // u32          outfile_format;
  @u32()
  external int outfile_format;
  // u32          remove_timer;
  @u32()
  external int remove_timer;
  // u32          restore_timer;
  @u32()
  external int restore_timer;
  // u32          rp_files_cnt;
  @u32()
  external int rp_files_cnt;
  // u32          rp_gen;
  @u32()
  external int rp_gen;
  // u32          rp_gen_func_max;
  @u32()
  external int rp_gen_func_max;
  // u32          rp_gen_func_min;
  @u32()
  external int rp_gen_func_min;
  // u32          rp_gen_seed;
  @u32()
  external int rp_gen_seed;
  // u32          runtime;
  @u32()
  external int runtime;
  // u32          scrypt_tmto;
  @u32()
  external int scrypt_tmto;
  // u32          segment_size;
  @u32()
  external int segment_size;
  // u32          status_timer;
  @u32()
  external int status_timer;
  // u32          stdin_timeout_abort;
  @u32()
  external int stdin_timeout_abort;
  // u32          veracrypt_pim_start;
  @u32()
  external int veracrypt_pim_start;
  // u32          veracrypt_pim_stop;
  @u32()
  external int veracrypt_pim_stop;
  // u32          workload_profile;
  @u32()
  external int workload_profile;
  // u64          limit;
  @u64()
  external int limit;
  // u64          skip;
  @u64()
  external int skip;
}
typedef user_options_t = user_options;

class user_options_extra extends ffi.Struct {
  // u32 attack_kern;
  @u32()
  external int attack_kern;

  // u32 rule_len_r;
  @u32()
  external int rule_len_r;
  // u32 rule_len_l;
  @u32()
  external int rule_len_l;

  // u32 wordlist_mode;
  @u32()
  external int wordlist_mode;

  // char   separator;
  @ffi.Char()
  external int separator;

  // char  *hc_hash;   // can be filename or string
  external ffi.Pointer<ffi.Char> hc_hash;

  // int    hc_workc;  // can be 0 in bf-mode = default mask
  @ffi.Int()
  external int hc_workc;
  // char **hc_workv;
  external ffi.Pointer<ffi.Pointer<ffi.Char>> hc_workv;
}
typedef user_options_extra_t = user_options_extra;

class hc_device_param extends ffi.Opaque {} // TODO: A BUNCH OF STUFF
typedef hc_device_param_t = user_options_extra;

class backend_ctx extends ffi.Struct {
  // bool                enabled;
  @ffi.Bool()
  external bool enabled;

  // // global rc

  // bool                memory_hit_warning;
  @ffi.Bool()
  external bool memory_hit_warning;
  // bool                runtime_skip_warning;
  @ffi.Bool()
  external bool runtime_skip_warning;
  // bool                kernel_build_warning;
  @ffi.Bool()
  external bool kernel_build_warning;
  // bool                kernel_create_warning;
  @ffi.Bool()
  external bool kernel_create_warning;
  // bool                kernel_accel_warnings;
  @ffi.Bool()
  external bool kernel_accel_warnings;
  // bool                extra_size_warning;
  @ffi.Bool()
  external bool extra_size_warning;
  // bool                mixed_warnings;
  @ffi.Bool()
  external bool mixed_warnings;
  // bool                self_test_warnings;
  @ffi.Bool()
  external bool self_test_warnings;

  // // generic

  // void               *cuda;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> cuda;
  // void               *hip;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> hip;
  // void               *mtl;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> mtl;
  // void               *ocl;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> ocl;

  // void               *nvrtc;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> nvrtc;
  // void               *hiprtc;
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> hiprtc;

  // int                 backend_device_from_cuda[DEVICES_MAX];                              // from cuda device index to backend device index
  @ffi.Array<ffi.Int>.multi([DEVICES_MAX])
  external ffi.Array<ffi.Int> backend_device_from_cuda;
  // int                 backend_device_from_hip[DEVICES_MAX];                               // from hip device index to backend device index
  @ffi.Array<ffi.Int>.multi([DEVICES_MAX])
  external ffi.Array<ffi.Int> backend_device_from_hip;
  // int                 backend_device_from_metal[DEVICES_MAX];                             // from metal device index to backend device index
  @ffi.Array<ffi.Int>.multi([DEVICES_MAX])
  external ffi.Array<ffi.Int> backend_device_from_metal;
  // int                 backend_device_from_opencl[DEVICES_MAX];                            // from opencl device index to backend device index
  @ffi.Array<ffi.Int>.multi([DEVICES_MAX])
  external ffi.Array<ffi.Int> backend_device_from_opencl;
  // int                 backend_device_from_opencl_platform[CL_PLATFORMS_MAX][DEVICES_MAX]; // from opencl device index to backend device index (by platform)
  @ffi.Array<ffi.Int>.multi([CL_PLATFORMS_MAX, DEVICES_MAX])
  external ffi.Array<ffi.Array<ffi.Int>> backend_device_from_opencl_platform;

  // int                 backend_devices_cnt;
  @ffi.Int()
  external int backend_devices_cnt;
  // int                 backend_devices_active;
  @ffi.Int()
  external int backend_devices_active;

  // int                 cuda_devices_cnt;
  @ffi.Int()
  external int cuda_devices_cnt;
  // int                 cuda_devices_active;
  @ffi.Int()
  external int cuda_devices_active;
  // int                 hip_devices_cnt;
  @ffi.Int()
  external int hip_devices_cnt;
  // int                 hip_devices_active;
  @ffi.Int()
  external int hip_devices_active;
  // int                 metal_devices_cnt;
  @ffi.Int()
  external int metal_devices_cnt;
  // int                 metal_devices_active;
  @ffi.Int()
  external int metal_devices_active;
  // int                 opencl_devices_cnt;
  @ffi.Int()
  external int opencl_devices_cnt;
  // int                 opencl_devices_active;
  @ffi.Int()
  external int opencl_devices_active;

  // u64                 backend_devices_filter;
  @u64()
  external int backend_devices_filter;

  // hc_device_param_t  *devices_param;
  external ffi.Pointer<hc_device_param_t> devices_param;

  // u32                 hardware_power_all;
  @u32()
  external int hardware_power_all;

  // u64                 kernel_power_all;
  @u64()
  external int kernel_power_all;
  // u64                 kernel_power_final; // we save that so that all divisions are done from the same base
  @u64()
  external int kernel_power_final;

  // double              target_msec;
  @ffi.Double()
  external double target_msec;

  // bool                need_adl;
  @ffi.Bool()
  external bool need_adl;
  // bool                need_nvml;
  @ffi.Bool()
  external bool need_nvml;
  // bool                need_nvapi;
  @ffi.Bool()
  external bool need_nvapi;
  // bool                need_sysfs_amdgpu;
  @ffi.Bool()
  external bool need_sysfs_amdgpu;
  // bool                need_sysfs_cpu;
  @ffi.Bool()
  external bool need_sysfs_cpu;
  // bool                need_iokit;
  @ffi.Bool()
  external bool need_iokit;

  // int                 comptime;
  @ffi.Int()
  external int comptime;

  // int                 force_jit_compilation;
  @ffi.Int()
  external int force_jit_compilation;

  // // cuda

  // int                 rc_cuda_init;
  @ffi.Int()
  external int rc_cuda_init;
  // int                 rc_nvrtc_init;
  @ffi.Int()
  external int rc_nvrtc_init;

  // int                 nvrtc_driver_version;
  @ffi.Int()
  external int nvrtc_driver_version;
  // int                 cuda_driver_version;
  @ffi.Int()
  external int cuda_driver_version;

  // // hip

  // int                 rc_hip_init;
  @ffi.Int()
  external int rc_hip_init;
  // int                 rc_hiprtc_init;
  @ffi.Int()
  external int rc_hiprtc_init;

  // int                 hip_runtimeVersion;
  @ffi.Int()
  external int hip_runtimeVersion;
  // int                 hip_driverVersion;
  @ffi.Int()
  external int hip_driverVersion;

  // // metal

  // int                 rc_metal_init;
  @ffi.Int()
  external int rc_metal_init;

  // unsigned int        metal_runtimeVersion;
  @ffi.UnsignedInt()
  external int metal_runtimeVersion;
  // char               *metal_runtimeVersionStr;
  external ffi.Pointer<ffi.Char> metal_runtimeVersionStr;

  // // opencl

  // cl_platform_id     *opencl_platforms;
  external ffi.Pointer<cl_platform_id> opencl_platforms;
  // cl_uint             opencl_platforms_cnt; TODO: I just don't want to do it tbh...
  // cl_device_id      **opencl_platforms_devices;
  // cl_uint            *opencl_platforms_devices_cnt;
  // char              **opencl_platforms_name;
  // char              **opencl_platforms_vendor;
  // cl_uint            *opencl_platforms_vendor_id;
  // char              **opencl_platforms_version;

  // cl_device_type      opencl_device_types_filter;
}
typedef backend_ctx_t = backend_ctx;

class module_ctx extends ffi.Struct {
  // size_t      module_context_size;
  @size_t()
  external int module_context_size;
  // int         module_interface_version;
  @ffi.Int()
  external int module_interface_version;

  // hc_dynlib_t module_handle;
  external ffi.Pointer<hc_dynlib_t> module_handle;

  // MODULE_INIT module_init;
  external ffi.Pointer<MODULE_INIT> module_init;

  // void      **hook_extra_params; // free for module to use (for instance: library handles)
  external ffi.Pointer<ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>> hook_extra_params;

  // u32         (*module_attack_exec)             (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_attack_exec;
  // void       *(*module_benchmark_esalt)         (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>>> module_benchmark_esalt;
  // void       *(*module_benchmark_hook_salt)     (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>>> module_benchmark_hook_salt;
  // const char *(*module_benchmark_mask)          (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.Pointer<ffi.NativeFunction<ffi.Char Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>>> module_benchmark_mask;
  // const char *(*module_benchmark_charset)       (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.Pointer<ffi.NativeFunction<ffi.Char Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>>> module_benchmark_charset;
  // salt_t     *(*module_benchmark_salt)          (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.Pointer<ffi.NativeFunction<salt_t Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>>> module_benchmark_salt;
  // const char *(*module_deprecated_notice)       (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.Pointer<ffi.NativeFunction<ffi.Char Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>>> module_deprecated_notice;
  // u32         (*module_dgst_pos0)               (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_dgst_pos0;
  // u32         (*module_dgst_pos1)               (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_dgst_pos1;
  // u32         (*module_dgst_pos2)               (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_dgst_pos2;
  // u32         (*module_dgst_pos3)               (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_dgst_pos3;
  // u32         (*module_dgst_size)               (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_dgst_size;
  // bool        (*module_dictstat_disable)        (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_dictstat_disable;
  // u64         (*module_esalt_size)              (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u64 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_esalt_size;
  // const char *(*module_extra_tuningdb_block)    (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.Pointer<ffi.NativeFunction<ffi.Char Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>>> module_extra_tuningdb_block;
  // u32         (*module_forced_outfile_format)   (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_forced_outfile_format;
  // u32         (*module_hash_category)           (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_hash_category;
  // const char *(*module_hash_name)               (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.Pointer<ffi.NativeFunction<ffi.Char Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>>> module_hash_name;
  // int         (*module_hash_mode)               (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<int Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_hash_mode;
  // u32         (*module_hashes_count_min)        (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_hashes_count_min;
  // u32         (*module_hashes_count_max)        (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_hashes_count_max;
  // bool        (*module_hlfmt_disable)           (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_hlfmt_disable;
  // u64         (*module_hook_salt_size)          (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u64 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_hook_salt_size;
  // u64         (*module_hook_size)               (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u64 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_hook_size;
  // u32         (*module_kernel_accel_min)        (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_kernel_accel_min;
  // u32         (*module_kernel_accel_max)        (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_kernel_accel_max;
  // u32         (*module_kernel_loops_min)        (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_kernel_loops_min;
  // u32         (*module_kernel_loops_max)        (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_kernel_loops_max;
  // u32         (*module_kernel_threads_min)      (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_kernel_threads_min;
  // u32         (*module_kernel_threads_max)      (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_kernel_threads_max;
  // u64         (*module_kern_type)               (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u64 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_kern_type;
  // u32         (*module_opti_type)               (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_opti_type;
  // u64         (*module_opts_type)               (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u64 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_opts_type;
  // bool        (*module_outfile_check_disable)   (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_outfile_check_disable;
  // bool        (*module_outfile_check_nocomp)    (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_outfile_check_nocomp;
  // bool        (*module_potfile_disable)         (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_potfile_disable;
  // bool        (*module_potfile_keep_all_hashes) (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_potfile_keep_all_hashes;
  // u32         (*module_pwdump_column)           (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_pwdump_column;
  // u32         (*module_pw_min)                  (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_pw_min;
  // u32         (*module_pw_max)                  (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_pw_max;
  // u32         (*module_salt_min)                (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_salt_min;
  // u32         (*module_salt_max)                (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_salt_max;
  // u32         (*module_salt_type)               (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_salt_type;
  // char        (*module_separator)               (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Char Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_separator;
  // const char *(*module_st_hash)                 (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.Pointer<ffi.NativeFunction<ffi.Char Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>>> module_st_hash;
  // const char *(*module_st_pass)                 (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.Pointer<ffi.NativeFunction<ffi.Char Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>>> module_st_pass;
  // u64         (*module_tmp_size)                (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u64 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_tmp_size;
  // bool        (*module_warmup_disable)          (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_warmup_disable;

  // int         (*module_hash_binary_count)       (const hashes_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashes_t>)>> module_hash_binary_count;
  // int         (*module_hash_binary_parse)       (const hashconfig_t *, const user_options_t *, const user_options_extra_t *, hashes_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>, ffi.Pointer<hashes_t>)>> module_hash_binary_parse;
  // int         (*module_hash_binary_save)        (const hashes_t *, const u32, const u32, char **);
  external ffi.Pointer<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashes_t>, u32, ffi.Pointer<ffi.Pointer<ffi.Char>>)>> module_hash_binary_save;

  // int         (*module_hash_decode_postprocess) (const hashconfig_t *,       void *,       salt_t *,       void *,       void *,       hashinfo_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<salt_t Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<hashinfo_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_hash_decode_postprocess;
  // int         (*module_hash_decode_potfile)     (const hashconfig_t *,       void *,       salt_t *,       void *,       void *,       hashinfo_t *, const char *, const int, void *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<salt_t Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<hashinfo_t>, ffi.Pointer<ffi.Char>, ffi.Int, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>)>> module_hash_decode_potfile;
  // int         (*module_hash_decode_zero_hash)   (const hashconfig_t *,       void *,       salt_t *,       void *,       void *,       hashinfo_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<salt_t Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<hashinfo_t>)>> module_hash_decode_zero_hash;
  // int         (*module_hash_decode)             (const hashconfig_t *,       void *,       salt_t *,       void *,       void *,       hashinfo_t *, const char *, const int);
  external ffi.Pointer<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<salt_t Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<hashinfo_t>, ffi.Pointer<ffi.Char>, ffi.Int)>> module_hash_decode;
  // int         (*module_hash_encode_potfile)     (const hashconfig_t *, const void *, const salt_t *, const void *, const void *, const hashinfo_t *,       char *,       int, const void *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<salt_t Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<hashinfo_t>, ffi.Pointer<ffi.Char>, ffi.Int, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>)>> module_hash_encode_potfile;
  // int         (*module_hash_encode_status)      (const hashconfig_t *, const void *, const salt_t *, const void *, const void *, const hashinfo_t *,       char *,       int);
  external ffi.Pointer<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<salt_t Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<hashinfo_t>, ffi.Pointer<ffi.Char>, ffi.Int)>> module_hash_encode_status;
  // int         (*module_hash_encode)             (const hashconfig_t *, const void *, const salt_t *, const void *, const void *, const hashinfo_t *,       char *,       int);
  external ffi.Pointer<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<salt_t Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<hashinfo_t>, ffi.Pointer<ffi.Char>, ffi.Int)>> module_hash_encode;

  // u64         (*module_kern_type_dynamic)       (const hashconfig_t *, const void *, const salt_t *, const void *, const void *, const hashinfo_t *);
  external ffi.Pointer<ffi.NativeFunction<u64 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<salt_t Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<hashinfo_t>, ffi.Pointer<ffi.Char>, ffi.Int)>> module_kern_type_dynamic;
  // u64         (*module_extra_buffer_size)       (const hashconfig_t *, const user_options_t *, const user_options_extra_t *, const hashes_t *, const hc_device_param_t *);
  external ffi.Pointer<ffi.NativeFunction<u64 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>, ffi.Pointer<hashes_t>, ffi.Pointer<hc_device_param_t>)>> module_extra_buffer_size;
  // u64         (*module_extra_tmp_size)          (const hashconfig_t *, const user_options_t *, const user_options_extra_t *, const hashes_t *);
  external ffi.Pointer<ffi.NativeFunction<u64 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>, ffi.Pointer<hashes_t>)>> module_extra_tmp_size;
  // char       *(*module_jit_build_options)       (const hashconfig_t *, const user_options_t *, const user_options_extra_t *, const hashes_t *, const hc_device_param_t *);
  external ffi.Pointer<ffi.Pointer<ffi.NativeFunction<ffi.Char Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>, ffi.Pointer<hashes_t>, ffi.Pointer<hc_device_param_t>)>>> module_jit_build_options;
  // bool        (*module_jit_cache_disable)       (const hashconfig_t *, const user_options_t *, const user_options_extra_t *, const hashes_t *, const hc_device_param_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>, ffi.Pointer<hashes_t>, ffi.Pointer<hc_device_param_t>)>> module_jit_cache_disable;
  // u32         (*module_deep_comp_kernel)        (const hashes_t *, const u32, const u32);
  external ffi.Pointer<ffi.NativeFunction<u32 Function(ffi.Pointer<hashes_t>, u32, u32)>> module_deep_comp_kernel;
  // int         (*module_hash_init_selftest)      (const hashconfig_t *, hash_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<hash_t>)>> module_hash_init_selftest;

  // u64         (*module_hook_extra_param_size)   (const hashconfig_t *, const user_options_t *, const user_options_extra_t *);
  external ffi.Pointer<ffi.NativeFunction<u64 Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>)>> module_hook_extra_param_size;
  // bool        (*module_hook_extra_param_init)   (const hashconfig_t *, const user_options_t *, const user_options_extra_t *, const folder_config_t *, const backend_ctx_t *, void *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>, ffi.Pointer<folder_config_t>, ffi.Pointer<backend_ctx_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>)>> module_hook_extra_param_init;
  // bool        (*module_hook_extra_param_term)   (const hashconfig_t *, const user_options_t *, const user_options_extra_t *, const folder_config_t *, const backend_ctx_t *, void *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>, ffi.Pointer<folder_config_t>, ffi.Pointer<backend_ctx_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>)>> module_hook_extra_param_term;

  // void        (*module_hook12)                  (hc_device_param_t *, const void *, const void *, const u32, const u64);
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<hc_device_param_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, u32, u64)>> module_hook12;
  // void        (*module_hook23)                  (hc_device_param_t *, const void *, const void *, const u32, const u64);
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<hc_device_param_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, u32, u64)>> module_hook23;

  // int         (*module_build_plain_postprocess) (const hashconfig_t *, const hashes_t *, const void *, const u32 *, const size_t, const int, u32 *, const size_t);
  external ffi.Pointer<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<hashes_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, ffi.Pointer<u32>, size_t, ffi.Int, ffi.Pointer<u32>, size_t)>> module_build_plain_postprocess;

  // bool        (*module_unstable_warning)        (const hashconfig_t *, const user_options_t *, const user_options_extra_t *, const hc_device_param_t *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<user_options_t>, ffi.Pointer<user_options_extra_t>, ffi.Pointer<hc_device_param_t>)>> module_unstable_warning;

  // bool        (*module_potfile_custom_check)    (const hashconfig_t *, const hash_t *, const hash_t *, const void *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<hashconfig_t>, ffi.Pointer<hash_t>, ffi.Pointer<hash_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>)>> module_potfile_custom_check;
}
typedef module_ctx_t = module_ctx;

class outcheck_ctx extends ffi.Struct {
  // bool enabled;
  @ffi.Bool()
  external bool enabled;

  // char *root_directory;
  external ffi.Pointer<ffi.Char> root_directory;
}
typedef outcheck_ctx_t = outcheck_ctx;

class outfile_ctx extends ffi.Struct {
  // HCFILE  fp;
  external HCFILE fp;

  // u32     outfile_format;
  @u32()
  external int outfile_format;
  // bool    outfile_autohex;
  @ffi.Bool()
  external bool outfile_autohex;

  // char   *filename;
  external ffi.Pointer<ffi.Char> filename;
}
typedef outfile_ctx_t = outfile_ctx;

class pidfile_data extends ffi.Struct {
  // u32 pid;
  @u32()
  external int pid;
}
typedef pidfile_data_t = pidfile_data;

class pidfile_ctx extends ffi.Struct {
  // u32   pid;
  @u32()
  external int pid;
  // char *filename;
  external ffi.Pointer<ffi.Char> filename;

  // pidfile_data_t *pd;
  external ffi.Pointer<pidfile_data_t> pd;

  // bool  pidfile_written;
  @ffi.Bool()
  external bool pidfile_written;
}
typedef pidfile_ctx_t = pidfile_ctx;

class potfile_ctx extends ffi.Struct {
  // HCFILE   fp;
  external HCFILE fp;

  // bool     enabled;
  @ffi.Bool()
  external bool enabled;

  // char    *filename;
  external ffi.Pointer<ffi.Char> filename;

  // u8      *out_buf; // allocates [HCBUFSIZ_LARGE];
  external ffi.Pointer<u8> out_buf;
  // u8      *tmp_buf; // allocates [HCBUFSIZ_LARGE];
  external ffi.Pointer<u8> tmp_buf;
}
typedef potfile_ctx_t = potfile_ctx;

class restore_data extends ffi.Struct {
  // int  version;
  @ffi.Int()
  external int version;
  // char cwd[256];
  @ffi.Array<ffi.Char>.multi([256])
  external ffi.Array<ffi.Char> char;

  // u32  dicts_pos;
  @u32()
  external int dicts_pos;
  // u32  masks_pos;
  @u32()
  external int masks_pos;

  // u64  words_cur;
  @u64()
  external int words_cur;

  // u32  argc;
  @u32()
  external int argc;
  // char **argv;
  external ffi.Pointer<ffi.Pointer<ffi.Char>> argv;
}
typedef restore_data_t = restore_data;

class restore_ctx extends ffi.Struct {
  // bool    enabled;
  @ffi.Bool()
  external bool enabled;

  // bool    restore_execute;
  @ffi.Bool()
  external bool restore_execute;

  // int     argc;
  @ffi.Int()
  external int argc;
  // char  **argv;
  external ffi.Pointer<ffi.Pointer<ffi.Char>> argv;

  // char   *eff_restore_file;
  external ffi.Pointer<ffi.Char> eff_restore_file;
  // char   *new_restore_file;
  external ffi.Pointer<ffi.Char> new_restore_file;

  // restore_data_t *rd;
  external ffi.Pointer<restore_data_t> rd;

  // u32  dicts_pos_prev;
  @u32()
  external int dicts_pos_prev;
  // u32  masks_pos_prev;
  @u32()
  external int masks_pos_prev;
  // u64  words_cur_prev;
  @u64()
  external int words_cur_prev;
}
typedef restore_ctx_t = restore_ctx;

class device_info extends ffi.Struct {
  // bool    skipped_dev;
  @ffi.Bool()
  external bool skipped_dev;
  // bool    skipped_warning_dev;
  @ffi.Bool()
  external bool skipped_warning_dev;
  // double  hashes_msec_dev;
  @ffi.Double()
  external double hashes_msec_dev;
  // double  hashes_msec_dev_benchmark;
  @ffi.Double()
  external double hashes_msec_dev_benchmark;
  // double  exec_msec_dev;
  @ffi.Double()
  external double exec_msec_dev;
  // char   *speed_sec_dev;
  external ffi.Pointer<ffi.Char> speed_sec_dev;
  // char   *guess_candidates_dev;
  external ffi.Pointer<ffi.Char> guess_candidates_dev;
  // #if defined(__APPLE__)
  // char   *hwmon_fan_dev;
  external ffi.Pointer<ffi.Char> hwmon_fan_dev;
  // #endif
  // char   *hwmon_dev;
  external ffi.Pointer<ffi.Char> hwmon_dev;
  // int     corespeed_dev;
  @ffi.Int()
  external int corespeed_dev;
  // int     memoryspeed_dev;
  @ffi.Int()
  external int memoryspeed_dev;
  // double  runtime_msec_dev;
  @ffi.Double()
  external double runtime_msec_dev;
  // u64     progress_dev;
  @u64()
  external int progress_dev;
  // int     kernel_accel_dev;
  @ffi.Int()
  external int kernel_accel_dev;
  // int     kernel_loops_dev;
  @ffi.Int()
  external int kernel_loops_dev;
  // int     kernel_threads_dev;
  @ffi.Int()
  external int kernel_threads_dev;
  // int     vector_width_dev;
  @ffi.Int()
  external int vector_width_dev;
  // int     salt_pos_dev;
  @ffi.Int()
  external int salt_pos_dev;
  // int     innerloop_pos_dev;
  @ffi.Int()
  external int innerloop_pos_dev;
  // int     innerloop_left_dev;
  @ffi.Int()
  external int innerloop_left_dev;
  // int     iteration_pos_dev;
  @ffi.Int()
  external int iteration_pos_dev;
  // int     iteration_left_dev;
  @ffi.Int()
  external int iteration_left_dev;
  // char   *device_name;
  external ffi.Pointer<ffi.Char> device_name;
  // cl_device_type device_type;
  @cl_device_type()
  external int device_type;
  // #ifdef WITH_BRAIN
  // int     brain_link_client_id_dev;
  @ffi.Int()
  external int brain_link_client_id_dev;
  // int     brain_link_status_dev;
  @ffi.Int()
  external int brain_link_status_dev;
  // char   *brain_link_recv_bytes_dev;
  external ffi.Pointer<ffi.Char> brain_link_recv_bytes_dev;
  // char   *brain_link_send_bytes_dev;
  external ffi.Pointer<ffi.Char> brain_link_send_bytes_dev;
  // char   *brain_link_recv_bytes_sec_dev;
  external ffi.Pointer<ffi.Char> brain_link_recv_bytes_sec_dev;
  // char   *brain_link_send_bytes_sec_dev;
  external ffi.Pointer<ffi.Char> brain_link_send_bytes_sec_dev;
  // double  brain_link_time_recv_dev;
  @ffi.Double()
  external double brain_link_time_recv_dev;
  // double  brain_link_time_send_dev;
  @ffi.Double()
  external double brain_link_time_send_dev;
  // #endif
}
typedef device_info_t = device_info;

class hashcat_status extends ffi.Struct {
  // char       *hash_target;
  external ffi.Pointer<ffi.Char> hash_target;
  // char       *hash_name;
  external ffi.Pointer<ffi.Char> hash_name;
  // int         guess_mode;
  @ffi.Int()
  external int guess_mode;
  // char       *guess_base;
  external ffi.Pointer<ffi.Char> guess_base;
  // int         guess_base_offset;
  @ffi.Int()
  external int guess_base_offset;
  // int         guess_base_count;
  @ffi.Int()
  external int guess_base_count;
  // double      guess_base_percent;
  @ffi.Double()
  external double guess_base_percent;
  // char       *guess_mod;
  external ffi.Pointer<ffi.Char> guess_mod;
  // int         guess_mod_offset;
  @ffi.Int()
  external int guess_mod_offset;
  // int         guess_mod_count;
  @ffi.Int()
  external int guess_mod_count;
  // double      guess_mod_percent;
  @ffi.Double()
  external double guess_mod_percent;
  // char       *guess_charset;
  external ffi.Pointer<ffi.Char> guess_charset;
  // int         guess_mask_length;
  @ffi.Int()
  external int guess_mask_length;
  // char       *session;
  external ffi.Pointer<ffi.Char> session;
  // #ifdef WITH_BRAIN
  // int         brain_session;
  @ffi.Int()
  external int brain_session;
  // int         brain_attack;
  @ffi.Int()
  external int brain_attack;
  // char       *brain_rx_all;
  external ffi.Pointer<ffi.Char> brain_rx_all;
  // char       *brain_tx_all;
  external ffi.Pointer<ffi.Char> brain_tx_all;
  // #endif
  // const char *status_string;
  external ffi.Pointer<ffi.Char> status_string;
  // int         status_number;
  @ffi.Int()
  external int status_number;
  // char       *time_estimated_absolute;
  external ffi.Pointer<ffi.Char> time_estimated_absolute;
  // char       *time_estimated_relative;
  external ffi.Pointer<ffi.Char> time_estimated_relative;
  // char       *time_started_absolute;
  external ffi.Pointer<ffi.Char> time_started_absolute;
  // char       *time_started_relative;
  external ffi.Pointer<ffi.Char> time_started_relative;
  // double      msec_paused;
  @ffi.Double()
  external double msec_paused;
  // double      msec_running;
  @ffi.Double()
  external double msec_running;
  // double      msec_real;
  @ffi.Double()
  external double msec_real;
  // int         digests_cnt;
  @ffi.Int()
  external int digests_cnt;
  // int         digests_done;
  @ffi.Int()
  external int digests_done;
  // int         digests_done_pot;
  @ffi.Int()
  external int digests_done_pot;
  // int         digests_done_zero;
  @ffi.Int()
  external int digests_done_zero;
  // int         digests_done_new;
  @ffi.Int()
  external int digests_done_new;
  // double      digests_percent;
  @ffi.Double()
  external double digests_percent;
  // double      digests_percent_new;
  @ffi.Double()
  external double digests_percent_new;
  // int         salts_cnt;
  @ffi.Int()
  external int salts_cnt;
  // int         salts_done;
  @ffi.Int()
  external int salts_done;
  // double      salts_percent;
  @ffi.Double()
  external double salts_percent;
  // int         progress_mode;
  @ffi.Int()
  external int progress_mode;
  // double      progress_finished_percent;
  @ffi.Double()
  external double progress_finished_percent;
  // u64         progress_cur;
  @u64()
  external int progress_cur;
  // u64         progress_cur_relative_skip;
  @u64()
  external int progress_cur_relative_skip;
  // u64         progress_done;
  @u64()
  external int progress_done;
  // u64         progress_end;
  @u64()
  external int progress_end;
  // u64         progress_end_relative_skip;
  @u64()
  external int progress_end_relative_skip;
  // u64         progress_ignore;
  @u64()
  external int progress_ignore;
  // u64         progress_rejected;
  @u64()
  external int progress_rejected;
  // double      progress_rejected_percent;
  @ffi.Double()
  external double progress_rejected_percent;
  // u64         progress_restored;
  @u64()
  external int progress_restored;
  // u64         progress_skip;
  @u64()
  external int progress_skip;
  // u64         restore_point;
  @u64()
  external int restore_point;
  // u64         restore_total;
  @u64()
  external int restore_total;
  // double      restore_percent;
  @ffi.Double()
  external double restore_percent;
  // int         cpt_cur_min;
  @ffi.Int()
  external int cpt_cur_min;
  // int         cpt_cur_hour;
  @ffi.Int()
  external int cpt_cur_hour;
  // int         cpt_cur_day;
  @ffi.Int()
  external int cpt_cur_day;
  // double      cpt_avg_min;
  @ffi.Double()
  external double cpt_avg_min;
  // double      cpt_avg_hour;
  @ffi.Double()
  external double cpt_avg_hour;
  // double      cpt_avg_day;
  @ffi.Double()
  external double cpt_avg_day;
  // char       *cpt;
  external ffi.Pointer<ffi.Char> cpt;

  // device_info_t device_info_buf[DEVICES_MAX];
  @ffi.Array<device_info_t>.multi([DEVICES_MAX])
  external ffi.Array<device_info_t> device_info_buf;
  // int           device_info_cnt;
  @ffi.Int()
  external int device_info_cnt;
  // int           device_info_active;
  @ffi.Int()
  external int device_info_active;

  // double  hashes_msec_all;
  @ffi.Double()
  external double hashes_msec_all;
  // double  exec_msec_all;
  @ffi.Double()
  external double exec_msec_all;
  // char   *speed_sec_all;
  external ffi.Pointer<ffi.Char> speed_sec_all;
}
typedef hashcat_status_t = hashcat_status;

class timespec extends ffi.Struct {
  @time_t()
  external int tv_sec;

  @ffi.Long()
  external int tv_nsec;
}
typedef hc_timer_t = timespec;

class status_ctx extends ffi.Struct {
  /**
   * main status
   */

  // bool accessible;
  @ffi.Bool()
  external bool accessible;

  // u32  devices_status;
  @u32()
  external int devices_status;

  /**
   * full (final) status snapshot
   */

  // hashcat_status_t *hashcat_status_final;
  external ffi.Pointer<hashcat_status_t> hashcat_status_final;

  /**
   * thread control
   */

  // bool run_main_level1;
  @ffi.Bool()
  external bool run_main_level1;
  // bool run_main_level2;
  @ffi.Bool()
  external bool run_main_level2;
  // bool run_main_level3;
  @ffi.Bool()
  external bool run_main_level3;
  // bool run_thread_level1;
  @ffi.Bool()
  external bool run_thread_level1;
  // bool run_thread_level2;
  @ffi.Bool()
  external bool run_thread_level2;

  // bool shutdown_inner;
  @ffi.Bool()
  external bool shutdown_inner;
  // bool shutdown_outer;
  @ffi.Bool()
  external bool shutdown_outer;

  // bool checkpoint_shutdown;
  @ffi.Bool()
  external bool checkpoint_shutdown;
  // bool finish_shutdown;
  @ffi.Bool()
  external bool finish_shutdown;

  // hc_thread_mutex_t mux_dispatcher; TODO
  // hc_thread_mutex_t mux_counter;
  // hc_thread_mutex_t mux_hwmon;
  // hc_thread_mutex_t mux_display;

  /**
   * workload
   */

  // u64  words_off;               // used by dispatcher; get_work () as offset; attention: needs to be redone on in restore case!
  @u64()
  external int words_off;
  // u64  words_cur;               // used by dispatcher; the different to words_cur_next is that this counter guarantees that the work from zero to this counter has been actually computed
  @u64()
  external int words_cur;
  // has been finished actually, can be used for restore point therefore
  // u64  words_base;              // the unamplified max keyspace
  @u64()
  external int words_base;
  // u64  words_cnt;               // the amplified max keyspace
  @u64()
  external int words_cnt;

  /**
   * progress
   */

  // u64 *words_progress_done;     // progress number of words done     per salt
  external ffi.Pointer<u64> words_progress_done;
  // u64 *words_progress_rejected; // progress number of words rejected per salt
  external ffi.Pointer<u64> words_progress_rejected;
  // u64 *words_progress_restored; // progress number of words restored per salt
  external ffi.Pointer<u64> words_progress_restored;

  /**
   * timer
   */

  // time_t runtime_start;
  @time_t()
  external int runtime_start;
  // time_t runtime_stop;
  @time_t()
  external int runtime_stop;

  // hc_timer_t timer_running;     // timer on current dict
  external hc_timer_t timer_running;
  // hc_timer_t timer_paused;      // timer on current dict
  external hc_timer_t timer_paused;

  // double  msec_paused;          // timer on current dict
  @ffi.Double()
  external double msec_paused;

  /**
   * read timeouts
   */

  // u32  stdin_read_timeout_cnt;
  @u32()
  external int stdin_read_timeout_cnt;
}
typedef status_ctx_t = status_ctx;

class S_kernel_rule_t extends ffi.Struct {
  // u32 cmds[32];
  @ffi.Array<u32>.multi([32])
  external ffi.Array<u32> cmds;
}
typedef kernel_rule_t = S_kernel_rule_t;

class straight_ctx extends ffi.Struct {
  // bool enabled;
  @ffi.Bool()
  external bool enabled;

  // u32             kernel_rules_cnt;
  @u32()
  external int kernel_rules_cnt;
  // kernel_rule_t  *kernel_rules_buf;
  external ffi.Pointer<kernel_rule_t> kernel_rules_buf;

  // char **dicts;
  external ffi.Pointer<ffi.Pointer<ffi.Char>> dicts;
  // u32    dicts_pos;
  @u32()
  external int dicts_pos;
  // u32    dicts_cnt;
  @u32()
  external int dicts_cnt;
  // u32    dicts_avail;
  @u32()
  external int dicts_avail;

  // char *dict;
  external ffi.Pointer<ffi.Char> dict;
}
typedef straight_ctx_t = straight_ctx;


class tuning_db_alias extends ffi.Struct {
  // char *device_name;
  external ffi.Pointer<ffi.Char> device_name;
  // char *alias_name;
  external ffi.Pointer<ffi.Char> alias_name;
}
typedef tuning_db_alias_t = tuning_db_alias;

class tuning_db_entry extends ffi.Struct {
  // const char *device_name;
  external ffi.Pointer<ffi.Char> device_name;
  // int         attack_mode;
  @ffi.Int()
  external int attack_mode;
  // int         hash_mode;
  @ffi.Int()
  external int hash_mode;
  // int         workload_profile;
  @ffi.Int()
  external int workload_profile;
  // int         vector_width;
  @ffi.Int()
  external int vector_width;
  // int         kernel_accel;
  @ffi.Int()
  external int kernel_accel;
  // int         kernel_loops;
  @ffi.Int()
  external int kernel_loops;
}
typedef tuning_db_entry_t = tuning_db_entry;

class tuning_db extends ffi.Struct {
  // bool enabled;
  @ffi.Bool()
  external bool enabled;

  // tuning_db_alias_t *alias_buf;
  external ffi.Pointer<tuning_db_alias_t> alias_buf;
  // int                alias_cnt;
  @ffi.Int()
  external int alias_cnt;
  // int                alias_alloc;
  @ffi.Int()
  external int alias_alloc;

  // tuning_db_entry_t *entry_buf;
  external ffi.Pointer<tuning_db_entry_t> entry_buf;
  // int                entry_cnt;
  @ffi.Int()
  external int entry_cnt;
  // int                entry_alloc;
  @ffi.Int()
  external int entry_alloc;
}
typedef tuning_db_t = tuning_db;

class wl_data extends ffi.Struct {
  // bool enabled;
  @ffi.Bool()
  external bool enabled;

  // char *buf;
  external ffi.Pointer<ffi.Char> buf;
  // u64  incr;
  @u64()
  external int incr;
  // u64  avail;
  @u64()
  external int avail;
  // u64  cnt;
  @u64()
  external int cnt;
  // u64  pos;
  @u64()
  external int pos;

  // bool    iconv_enabled;
  @ffi.Bool()
  external bool iconv_enabled;
  // iconv_t iconv_ctx;
  external iconv_t iconv_ctx;
  // char   *iconv_tmp;
  external ffi.Pointer<ffi.Char> iconv_tmp;

  // void (*func) (char *, u64, u64 *, u64 *);
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Char>, u64, ffi.Pointer<u64>, ffi.Pointer<u64>)>> func;
}
typedef wl_data_t = wl_data;

class hashcat_ctx extends ffi.Struct {
  // brain_ctx_t           *brain_ctx;
  external ffi.Pointer<brain_ctx_t> brain_ctx;
  // bitmap_ctx_t          *bitmap_ctx;
  external ffi.Pointer<bitmap_ctx_t> bitmap_ctx;
  // combinator_ctx_t      *combinator_ctx;
  external ffi.Pointer<combinator_ctx_t> combinator_ctx;
  // cpt_ctx_t             *cpt_ctx;
  external ffi.Pointer<cpt_ctx_t> cpt_ctx;
  // debugfile_ctx_t       *debugfile_ctx;
  external ffi.Pointer<debugfile_ctx_t> debugfile_ctx;
  // dictstat_ctx_t        *dictstat_ctx;
  external ffi.Pointer<dictstat_ctx_t> dictstat_ctx;
  // event_ctx_t           *event_ctx;
  external ffi.Pointer<event_ctx_t> event_ctx;
  // folder_config_t       *folder_config;
  external ffi.Pointer<folder_config_t> folder_config;
  // hashcat_user_t        *hashcat_user;
  external ffi.Pointer<hashcat_user_t> hashcat_user;
  // hashconfig_t          *hashconfig;
  external ffi.Pointer<hashconfig_t> hashconfig;
  // hashes_t              *hashes;
  external ffi.Pointer<hashes_t> hashes;
  // hwmon_ctx_t           *hwmon_ctx;
  external ffi.Pointer<hwmon_ctx_t> hwmon_ctx;
  // induct_ctx_t          *induct_ctx;
  external ffi.Pointer<induct_ctx_t> induct_ctx;
  // logfile_ctx_t         *logfile_ctx;
  external ffi.Pointer<logfile_ctx_t> logfile_ctx;
  // loopback_ctx_t        *loopback_ctx;
  external ffi.Pointer<loopback_ctx_t> loopback_ctx;
  // mask_ctx_t            *mask_ctx;
  external ffi.Pointer<mask_ctx_t> mask_ctx;
  // module_ctx_t          *module_ctx;
  external ffi.Pointer<module_ctx_t> module_ctx;
  // backend_ctx_t         *backend_ctx;
  external ffi.Pointer<backend_ctx_t> backend_ctx;
  // outcheck_ctx_t        *outcheck_ctx;
  external ffi.Pointer<outcheck_ctx_t> outcheck_ctx;
  // outfile_ctx_t         *outfile_ctx;
  external ffi.Pointer<outfile_ctx_t> outfile_ctx;
  // pidfile_ctx_t         *pidfile_ctx;
  external ffi.Pointer<pidfile_ctx_t> pidfile_ctx;
  // potfile_ctx_t         *potfile_ctx;
  external ffi.Pointer<potfile_ctx_t> potfile_ctx;
  // restore_ctx_t         *restore_ctx;
  external ffi.Pointer<restore_ctx_t> restore_ctx;
  // status_ctx_t          *status_ctx;
  external ffi.Pointer<status_ctx_t> status_ctx;
  // straight_ctx_t        *straight_ctx;
  external ffi.Pointer<straight_ctx_t> straight_ctx;
  // tuning_db_t           *tuning_db;
  external ffi.Pointer<tuning_db_t> tuning_db;
  // user_options_extra_t  *user_options_extra;
  external ffi.Pointer<user_options_extra_t> user_options_extra;
  // user_options_t        *user_options;
  external ffi.Pointer<user_options_t> user_options;
  // wl_data_t             *wl_data;
  external ffi.Pointer<wl_data_t> wl_data;

  // void (*event) (const u32, struct hashcat_ctx *, const void *, const size_t);
  external ffi.Pointer<ffi.NativeFunction<ffi.Void Function(u32, ffi.Pointer<hashcat_ctx>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>, size_t)>> event;
}
typedef hashcat_ctx_t = hashcat_ctx;
/// STRUCTS END
