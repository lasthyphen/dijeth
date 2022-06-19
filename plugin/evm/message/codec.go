// (c) 2019-2022, Ava Labs, Inc. All rights reserved.
// See the file LICENSE for licensing terms.

package message

import (
	"github.com/lasthyphen/dijetsgo/codec"
	"github.com/lasthyphen/dijetsgo/codec/linearcodec"
	"github.com/lasthyphen/dijetsgo/utils/units"
	"github.com/lasthyphen/dijetsgo/utils/wrappers"
)

const Version = uint16(0)
const maxMessageSize = 1 * units.MiB

func BuildCodec() (codec.Manager, error) {
	codecManager := codec.NewManager(maxMessageSize)
	c := linearcodec.NewDefault()
	errs := wrappers.Errs{}
	errs.Add(
		c.RegisterType(&AtomicTx{}),
		c.RegisterType(&EthTxs{}),
	)
	errs.Add(codecManager.RegisterCodec(Version, c))
	return codecManager, errs.Err
}
