module dgbm;

import core.stdc.config;


extern (C):

enum gbm_bo_format {
    GBM_BO_FORMAT_XRGB8888 = 0,
    GBM_BO_FORMAT_ARGB8888 = 1
}

enum gbm_bo_flags {
    GBM_BO_USE_SCANOUT = 1,
    GBM_BO_USE_CURSOR = 2,
    GBM_BO_USE_CURSOR_64X64 = 2,
    GBM_BO_USE_RENDERING = 4,
    GBM_BO_USE_WRITE = 8
}

struct gbm_import_fd_data {
    int fd;
    uint width;
    uint height;
    uint stride;
    uint format;
}

struct gbm_bo;
struct gbm_device;
struct gbm_surface;


union gbm_bo_handle {
    void* ptr;
    int s32;
    uint u32;
    long s64;
    ulong u64;
}

int      gbm_device_get_fd(gbm_device* gbm);
const(char)* gbm_device_get_backend_name(gbm_device* gbm);
int gbm_device_is_format_supported(gbm_device* gbm, uint format, uint usage);
void gbm_device_destroy(gbm_device* gbm);
gbm_device* gbm_create_device(int fd);
gbm_bo* gbm_bo_create(gbm_device* gbm, uint width, uint height, uint format, uint flags);
gbm_bo* gbm_bo_import(gbm_device* gbm, uint type, void* buffer, uint usage);
uint gbm_bo_get_width(gbm_bo* bo);
uint gbm_bo_get_height(gbm_bo* bo);
uint gbm_bo_get_stride(gbm_bo* bo);
uint gbm_bo_get_format(gbm_bo* bo);
gbm_device* gbm_bo_get_device(gbm_bo* bo);
gbm_bo_handle gbm_bo_get_handle(gbm_bo* bo);
int gbm_bo_get_fd(gbm_bo* bo);
int gbm_bo_write(gbm_bo* bo, const(void)* buf, size_t count);
void gbm_bo_set_user_data(gbm_bo* bo, void* data, void function (gbm_bo*, void*) destroy_user_data);
void* gbm_bo_get_user_data(gbm_bo* bo);
void gbm_bo_destroy(gbm_bo* bo);
gbm_surface* gbm_surface_create(gbm_device* gbm, uint width, uint height, uint format, uint flags);
int gbm_surface_needs_lock_front_buffer(gbm_surface* surface);
gbm_bo* gbm_surface_lock_front_buffer(gbm_surface* surface);
void gbm_surface_release_buffer(gbm_surface* surface, gbm_bo* bo);
int gbm_surface_has_free_buffers(gbm_surface* surface);
void gbm_surface_destroy(gbm_surface* surface);


private template __gbm_fourcc_code(uint a, uint b, uint c, uint d) {
	enum __gbm_fourcc_code = (a | (b << 8) | (c << 16) | (d << 24));
}

enum GBM_FORMAT_BIG_ENDIAN = 1<<31;

enum GBM_FORMAT_C8 = __gbm_fourcc_code!('C', '8', ' ', ' ');

enum {
	GBM_FORMAT_RGB332 = __gbm_fourcc_code!('R', 'G', 'B', '8'),
	GBM_FORMAT_BGR233 = __gbm_fourcc_code!('B', 'G', 'R', '8')
}

enum {
	GBM_FORMAT_XRGB4444 = __gbm_fourcc_code!('X', 'R', '1', '2'),
	GBM_FORMAT_XBGR4444 = __gbm_fourcc_code!('X', 'B', '1', '2'),
	GBM_FORMAT_RGBX4444 = __gbm_fourcc_code!('R', 'X', '1', '2'),
	GBM_FORMAT_BGRX4444 = __gbm_fourcc_code!('B', 'X', '1', '2')
}

enum {
	GBM_FORMAT_ARGB4444 = __gbm_fourcc_code!('A', 'R', '1', '2'),
	GBM_FORMAT_ABGR4444 = __gbm_fourcc_code!('A', 'B', '1', '2'),
	GBM_FORMAT_RGBA4444 = __gbm_fourcc_code!('R', 'A', '1', '2'),
	GBM_FORMAT_BGRA4444 = __gbm_fourcc_code!('B', 'A', '1', '2')
}

enum {
	GBM_FORMAT_XRGB1555 = __gbm_fourcc_code!('X', 'R', '1', '5'),
	GBM_FORMAT_XBGR1555 = __gbm_fourcc_code!('X', 'B', '1', '5'),
	GBM_FORMAT_RGBX5551 = __gbm_fourcc_code!('R', 'X', '1', '5'),
	GBM_FORMAT_BGRX5551 = __gbm_fourcc_code!('B', 'X', '1', '5')
}

enum {
	GBM_FORMAT_ARGB1555 = __gbm_fourcc_code!('A', 'R', '1', '5'),
	GBM_FORMAT_ABGR1555 = __gbm_fourcc_code!('A', 'B', '1', '5'),
	GBM_FORMAT_RGBA5551 = __gbm_fourcc_code!('R', 'A', '1', '5'),
	GBM_FORMAT_BGRA5551 = __gbm_fourcc_code!('B', 'A', '1', '5')
}

enum {
	GBM_FORMAT_RGB565 = __gbm_fourcc_code!('R', 'G', '1', '6'),
	GBM_FORMAT_BGR565 = __gbm_fourcc_code!('B', 'G', '1', '6')
}

enum {
	GBM_FORMAT_RGB888 = __gbm_fourcc_code!('R', 'G', '2', '4'),
	GBM_FORMAT_BGR888 = __gbm_fourcc_code!('B', 'G', '2', '4')
}

enum {
	GBM_FORMAT_XRGB8888 = __gbm_fourcc_code!('X', 'R', '2', '4'),
	GBM_FORMAT_XBGR8888 = __gbm_fourcc_code!('X', 'B', '2', '4'),
	GBM_FORMAT_RGBX8888 = __gbm_fourcc_code!('R', 'X', '2', '4'),
	GBM_FORMAT_BGRX8888 = __gbm_fourcc_code!('B', 'X', '2', '4')
}

enum {
	GBM_FORMAT_ARGB8888 = __gbm_fourcc_code!('A', 'R', '2', '4'),
	GBM_FORMAT_ABGR8888 = __gbm_fourcc_code!('A', 'B', '2', '4'),
	GBM_FORMAT_RGBA8888 = __gbm_fourcc_code!('R', 'A', '2', '4'),
	GBM_FORMAT_BGRA8888 = __gbm_fourcc_code!('B', 'A', '2', '4')
}

enum {
	GBM_FORMAT_XRGB2101010 = __gbm_fourcc_code!('X', 'R', '3', '0'),
	GBM_FORMAT_XBGR2101010 = __gbm_fourcc_code!('X', 'B', '3', '0'),
	GBM_FORMAT_RGBX1010102 = __gbm_fourcc_code!('R', 'X', '3', '0'),
	GBM_FORMAT_BGRX1010102 = __gbm_fourcc_code!('B', 'X', '3', '0')
}

enum {
	GBM_FORMAT_ARGB2101010 = __gbm_fourcc_code!('A', 'R', '3', '0'),
	GBM_FORMAT_ABGR2101010 = __gbm_fourcc_code!('A', 'B', '3', '0'),
	GBM_FORMAT_RGBA1010102 = __gbm_fourcc_code!('R', 'A', '3', '0'),
	GBM_FORMAT_BGRA1010102 = __gbm_fourcc_code!('B', 'A', '3', '0')
}

enum {
	GBM_FORMAT_YUYV = __gbm_fourcc_code!('Y', 'U', 'Y', 'V'),
	GBM_FORMAT_YVYU = __gbm_fourcc_code!('Y', 'V', 'Y', 'U'),
	GBM_FORMAT_UYVY = __gbm_fourcc_code!('U', 'Y', 'V', 'Y'),
	GBM_FORMAT_VYUY = __gbm_fourcc_code!('V', 'Y', 'U', 'Y')
}

enum GBM_FORMAT_AYUV = __gbm_fourcc_code!('A', 'Y', 'U', 'V');

enum {
	GBM_FORMAT_NV12 = __gbm_fourcc_code!('N', 'V', '1', '2'),
	GBM_FORMAT_NV21 = __gbm_fourcc_code!('N', 'V', '2', '1'),
	GBM_FORMAT_NV16 = __gbm_fourcc_code!('N', 'V', '1', '6'),
	GBM_FORMAT_NV61 = __gbm_fourcc_code!('N', 'V', '6', '1')
}

enum {
	GBM_FORMAT_YUV410 = __gbm_fourcc_code!('Y', 'U', 'V', '9'),
	GBM_FORMAT_YVU410 = __gbm_fourcc_code!('Y', 'V', 'U', '9'),
	GBM_FORMAT_YUV411 = __gbm_fourcc_code!('Y', 'U', '1', '1'),
	GBM_FORMAT_YVU411 = __gbm_fourcc_code!('Y', 'V', '1', '1'),
	GBM_FORMAT_YUV420 = __gbm_fourcc_code!('Y', 'U', '1', '2'),
	GBM_FORMAT_YVU420 = __gbm_fourcc_code!('Y', 'V', '1', '2'),
	GBM_FORMAT_YUV422 = __gbm_fourcc_code!('Y', 'U', '1', '6'),
	GBM_FORMAT_YVU422 = __gbm_fourcc_code!('Y', 'V', '1', '6'),
	GBM_FORMAT_YUV444 = __gbm_fourcc_code!('Y', 'U', '2', '4'),
	GBM_FORMAT_YVU444 = __gbm_fourcc_code!('Y', 'V', '2', '4')
}