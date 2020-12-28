//
//  Header.h
//  Teeet
//
//  Created by xdf_yanqing on 12/25/20.
//

#pragma once

#include "../Base/Base.h"
#include <stdio.h>
#include <wchar.h>
namespace Tools
{
    template<typename T>
    inline T MinT(T t1, T t2)
    {
        return t1 < t2 ? t1 : t2;
    }

    EXPORT uint64_t os_gettime_ms(void);
    EXPORT size_t os_mbs_to_wcs(const char* str, size_t str_len, wchar_t* dst,
        size_t dst_size);
    EXPORT size_t os_utf8_to_wcs(const char* str, size_t len, wchar_t* dst,
        size_t dst_size);
    EXPORT size_t os_wcs_to_mbs(const wchar_t* str, size_t len, char* dst,
        size_t dst_size);
    EXPORT size_t os_wcs_to_utf8(const wchar_t* str, size_t len, char* dst,
        size_t dst_size);

    EXPORT size_t os_utf8_to_mbs(const char* str, size_t str_len, char* dst, size_t dst_size);
    EXPORT size_t os_mbs_to_utf8(const char* str, size_t str_len, char* dst, size_t dst_size);


    EXPORT size_t os_mbs_to_wcs_ptr(const char* str, size_t len, wchar_t** pstr);
    EXPORT size_t os_utf8_to_wcs_ptr(const char* str, size_t len, wchar_t** pstr);
    EXPORT size_t os_wcs_to_mbs_ptr(const wchar_t* str, size_t len, char** pstr);
    EXPORT size_t os_wcs_to_utf8_ptr(const wchar_t* str, size_t len, char** pstr);

    EXPORT size_t os_utf8_to_mbs_ptr(const char* str, size_t len, char** pstr);
    EXPORT size_t os_mbs_to_utf8_ptr(const char* str, size_t len, char** pstr);

    EXPORT int os_get_program_data_path(char* dst, size_t size, const char* name);
    EXPORT int os_get_executable_path(char* dst, size_t size, const char* name);

#define MKDIR_EXISTS 1
#define MKDIR_SUCCESS 0
#define MKDIR_ERROR -1

    EXPORT int os_mkdir(const char* path);
    EXPORT int os_mkdirs(const char* path);
    EXPORT int os_rename(const char* old_path, const char* new_path);
    EXPORT int os_copyfile(const char* file_in, const char* file_out);
    EXPORT int os_safe_replace(const char* target_path, const char* from_path,
        const char* backup_path);

    EXPORT FILE* os_wfopen(const wchar_t* path, const char* mode);
    EXPORT FILE* os_fopen(const char* path, const char* mode);
    EXPORT int64_t os_fgetsize(FILE* file);
#ifdef _WIN32
    EXPORT int os_stat(const char* file, struct stat* st);
#else
#define os_stat stat
#endif

    EXPORT int os_fseeki64(FILE* file, int64_t offset, int origin);
    EXPORT int64_t os_ftelli64(FILE* file);

    EXPORT size_t os_fread_mbs(FILE* file, char** pstr);
    EXPORT size_t os_fread_utf8(FILE* file, char** pstr);
    EXPORT double os_strtod(const char* str);
    EXPORT int os_dtostr(double value, char* dst, size_t size);
    EXPORT char* os_quick_read_utf8_file(const char* path);
    EXPORT bool os_quick_write_utf8_file(const char* path, const char* str,
        size_t len, bool marker);
    EXPORT bool os_quick_write_utf8_file_safe(const char* path, const char* str,
        size_t len, bool marker,
        const char* temp_ext,
        const char* backup_ext);
    EXPORT char* os_quick_read_mbs_file(const char* path);
    EXPORT bool os_quick_write_mbs_file(const char* path, const char* str,
        size_t len);
    EXPORT void* os_dlopen(const char* path);
    EXPORT void* os_dlsym(void* module, const char* func);
    EXPORT void os_dlclose(void* module);
}
