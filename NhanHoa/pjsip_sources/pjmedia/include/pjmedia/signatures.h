/* $Id$ */
/* 
 * Copyright (C) 2011-2011 Teluu Inc. (http://www.teluu.com)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA 
 */
#ifndef __PJMEDIA_SIGNATURES_H__
#define __PJMEDIA_SIGNATURES_H__

/**
 * @file pjmedia/signatures.h
 * @brief Standard PJMEDIA object signatures
 */
#include "types.h"

PJ_BEGIN_DECL

/**
 * @defgroup PJMEDIA_SIG Object Signatures
 * @ingroup PJMEDIA_BASE
 * @brief Standard PJMEDIA object signatures
 * @{
 *
 * Object signature is a 32-bit integral value similar to FOURCC to help
 * identify PJMEDIA objects such as media ports, transports, codecs, etc.
 * There are several uses of this signature, for example a media port can
 * use the port object signature to verify that the given port instance
 * is the one that it created, and a receiver of \ref PJMEDIA_EVENT can
 * use the signature of the publisher to know which object emitted the
 * event.
 *
 * The 32-bit value of an object signature is generated by the following
 * macro:
 *
 * \verbatim
   #define PJMEDIA_SIGNATURE(a,b,c,d)	(a<<24 | b<<16 | c<<8 | d)
 * \endverbatim
 *
 * The following convention is used to maintain order to the signature
 * values so that application can make use of it more effectively, and to
 * avoid conflict between the values themselves. For each object type or
 * class, a specific prefix will be assigned as signature, and a macro
 * is created to build a signature for such object:
 *
 * \verbatim
    Class               Signature  Signature creation and test macros
    ---------------------------------------------------------------
    Codec    		Cxxx	   PJMEDIA_SIG_CLASS_CODEC(b,c,d)
				   PJMEDIA_SIG_IS_CLASS_CODEC(sig)

    Audio codec 	CAxx	   PJMEDIA_SIG_CLASS_AUD_CODEC(c,d)
				   PJMEDIA_SIG_IS_CLASS_AUD_CODEC(sig)

    Video codec 	CVxx	   PJMEDIA_SIG_CLASS_VID_CODEC(c,d)
				   PJMEDIA_SIG_IS_CLASS_VID_CODEC(sig)

    Media port		Pxxx	   PJMEDIA_SIG_CLASS_PORT(b,c,d)
				   PJMEDIA_SIG_IS_CLASS_PORT(sig)

    Audio media port    PAxx	   PJMEDIA_SIG_CLASS_PORT_AUD(c,d)
				   PJMEDIA_SIG_IS_CLASS_PORT_AUD(sig)

    Video media port    PVxx	   PJMEDIA_SIG_CLASS_PORT_VID(c,d)
				   PJMEDIA_SIG_IS_CLASS_PORT_VID(sig)

    Video device	VDxx	   PJMEDIA_SIG_CLASS_VID_DEV(c,d)
				   PJMEDIA_SIG_IS_CLASS_VID_DEV(sig)

    Video other		VOxx	   PJMEDIA_SIG_CLASS_VID_OTHER(c,d)
				   PJMEDIA_SIG_IS_CLASS_VID_OTHER(sig)

    Application object	Axxx	   PJMEDIA_SIG_CLASS_APP(b,c,d)
				   PJMEDIA_SIG_IS_CLASS_APP(sig)

 * \endverbatim
 *
 * In addition, signatures created in application code should have lowercase
 * letters to avoid conflict with built-in objects.
 */

/**
 * Type to store object signature.
 */
typedef pj_uint32_t pjmedia_obj_sig;

/**
 * A utility function to convert signature to four letters string.
 *
 * @param sig		The signature value.
 * @param buf		Buffer to store the string, which MUST be at least
 * 			five bytes long.
 *
 * @return		The string.
 */
PJ_INLINE(const char*) pjmedia_sig_name(pjmedia_obj_sig sig, char buf[])
{
    return pjmedia_fourcc_name(sig, buf);
}

/**
 * Macro to generate signature from four ASCII letters.
 */
#define PJMEDIA_SIGNATURE(a,b,c,d)	PJMEDIA_FOURCC(a,b,c,d)

/*************************************************************************
 * Codec signature ('Cxxx'). Please keep the constant names sorted.
 */
#define PJMEDIA_SIG_CLASS_CODEC(b,c,d)	PJMEDIA_SIGNATURE('C',b,c,d)
#define PJMEDIA_SIG_IS_CLASS_CODEC(sig)	((sig) >> 24 == 'C')

/*************************************************************************
 * Audio codec signatures ('CAxx'). Please keep the constant names sorted.
 */
#define PJMEDIA_SIG_CLASS_AUD_CODEC(c,d) PJMEDIA_SIG_CLASS_CODEC('A',c,d)
#define PJMEDIA_SIG_IS_CLASS_AUD_CODEC(s) ((s)>>24=='C' && (s)>>16=='A')

/*************************************************************************
 * Video codec signatures ('CVxx'). Please keep the constant names sorted.
 */
#define PJMEDIA_SIG_CLASS_VID_CODEC(c,d) PJMEDIA_SIG_CLASS_CODEC('V',c,d)
#define PJMEDIA_SIG_IS_CLASS_VID_CODEC(sig) ((s)>>24=='C' && (s)>>16=='V')

#define PJMEDIA_SIG_VID_CODEC_FFMPEG	PJMEDIA_SIG_CLASS_VID_CODEC('F','F')

/*************************************************************************
 * Port signatures ('Pxxx'). Please keep the constant names sorted.
 */
#define PJMEDIA_SIG_CLASS_PORT(b,c,d)	PJMEDIA_SIGNATURE('P',b,c,d)
#define PJMEDIA_SIG_IS_CLASS_PORT(sig)	((sig) >> 24 == 'P')

/*************************************************************************
 * Audio ports signatures ('PAxx'). Please keep the constant names sorted.
 */
#define PJMEDIA_SIG_CLASS_PORT_AUD(c,d)	PJMEDIA_SIG_CLASS_PORT('A',c,d)
#define PJMEDIA_SIG_IS_CLASS_PORT_AUD(s) ((s)>>24=='P' && (s)>>16=='A')

#define PJMEDIA_SIG_PORT_BIDIR		PJMEDIA_SIG_CLASS_PORT_AUD('B','D')
#define PJMEDIA_SIG_PORT_CONF		PJMEDIA_SIG_CLASS_PORT_AUD('C','F')
#define PJMEDIA_SIG_PORT_CONF_PASV	PJMEDIA_SIG_CLASS_PORT_AUD('C','P')
#define PJMEDIA_SIG_PORT_CONF_SWITCH	PJMEDIA_SIG_CLASS_PORT_AUD('C','S')
#define PJMEDIA_SIG_PORT_ECHO		PJMEDIA_SIG_CLASS_PORT_AUD('E','C')
#define PJMEDIA_SIG_PORT_MEM_CAPTURE	PJMEDIA_SIG_CLASS_PORT_AUD('M','C')
#define PJMEDIA_SIG_PORT_MEM_PLAYER	PJMEDIA_SIG_CLASS_PORT_AUD('M','P')
#define PJMEDIA_SIG_PORT_NULL		PJMEDIA_SIG_CLASS_PORT_AUD('N','U')
#define PJMEDIA_SIG_PORT_RESAMPLE	PJMEDIA_SIG_CLASS_PORT_AUD('R','E')
#define PJMEDIA_SIG_PORT_SPLIT_COMB	PJMEDIA_SIG_CLASS_PORT_AUD('S','C')
#define PJMEDIA_SIG_PORT_SPLIT_COMB_P	PJMEDIA_SIG_CLASS_PORT_AUD('S','P')
#define PJMEDIA_SIG_PORT_STEREO		PJMEDIA_SIG_CLASS_PORT_AUD('S','R')
#define PJMEDIA_SIG_PORT_STREAM		PJMEDIA_SIG_CLASS_PORT_AUD('S','T')
#define PJMEDIA_SIG_PORT_TONEGEN	PJMEDIA_SIG_CLASS_PORT_AUD('T','O')
#define PJMEDIA_SIG_PORT_WAV_PLAYER	PJMEDIA_SIG_CLASS_PORT_AUD('W','P')
#define PJMEDIA_SIG_PORT_WAV_PLAYLIST	PJMEDIA_SIG_CLASS_PORT_AUD('W','Y')
#define PJMEDIA_SIG_PORT_WAV_WRITER	PJMEDIA_SIG_CLASS_PORT_AUD('W','W')


/*************************************************************************
 * Video ports signatures ('PVxx'). Please keep the constant names sorted.
 */
#define PJMEDIA_SIG_CLASS_PORT_VID(c,d)	PJMEDIA_SIG_CLASS_PORT('V',c,d)
#define PJMEDIA_SIG_IS_CLASS_PORT_VID(s) ((s)>>24=='P' && (s)>>16=='V')

/** AVI player signature. */
#define PJMEDIA_SIG_PORT_VID_AVI_PLAYER	PJMEDIA_SIG_CLASS_PORT_VID('A','V')
#define PJMEDIA_SIG_PORT_VID_STREAM	PJMEDIA_SIG_CLASS_PORT_VID('S','T')
#define PJMEDIA_SIG_PORT_VID_TEE	PJMEDIA_SIG_CLASS_PORT_VID('T','E')


/**************************************************************************
 * Video device signatures ('VDxx'). Please keep the constant names sorted.
 */
#define PJMEDIA_SIG_CLASS_VID_DEV(c,d)	PJMEDIA_SIGNATURE('V','D',c,d)
#define PJMEDIA_SIG_IS_CLASS_VID_DEV(s) ((s)>>24=='V' && (s)>>16=='D')

#define PJMEDIA_SIG_VID_DEV_COLORBAR	PJMEDIA_SIG_CLASS_VID_DEV('C','B')
#define PJMEDIA_SIG_VID_DEV_SDL		PJMEDIA_SIG_CLASS_VID_DEV('S','D')
#define PJMEDIA_SIG_VID_DEV_V4L2	PJMEDIA_SIG_CLASS_VID_DEV('V','2')
#define PJMEDIA_SIG_VID_DEV_DSHOW	PJMEDIA_SIG_CLASS_VID_DEV('D','S')
#define PJMEDIA_SIG_VID_DEV_QT		PJMEDIA_SIG_CLASS_VID_DEV('Q','T')
#define PJMEDIA_SIG_VID_DEV_IOS		PJMEDIA_SIG_CLASS_VID_DEV('I','P')


/*********************************************************************
 * Other video objects ('VOxx'). Please keep the constant names sorted.
 */
#define PJMEDIA_SIG_CLASS_VID_OTHER(c,d) PJMEDIA_SIGNATURE('V','O',c,d)
#define PJMEDIA_SIG_IS_CLASS_VID_OTHER(s) ((s)>>24=='V' && (s)>>16=='O')

#define PJMEDIA_SIG_VID_CONF		PJMEDIA_SIG_CLASS_VID_OTHER('C','F')
#define PJMEDIA_SIG_VID_PORT		PJMEDIA_SIG_CLASS_VID_OTHER('P','O')


/*********************************************************************
 * Application class ('Axxx').
 */
#define PJMEDIA_SIG_CLASS_APP(b,c,d)	PJMEDIA_SIGNATURE('A',b,c,d)
#define PJMEDIA_SIG_IS_CLASS_APP(s)	((s)>>24=='A')


/**
 * @}  PJSIP_MSG
 */


PJ_END_DECL

#endif	/* __PJMEDIA_SIGNATURES_H__ */
