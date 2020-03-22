import React, { useState, useEffect } from 'react'
import ReactDOM from 'react-dom'
import { DragDropContext } from 'react-beautiful-dnd'
import PropTypes from 'prop-types'
import consumer from '../channels/consumer'
import CardBoard from './CardBoard'

const CandidatesIndex = () => {
  const [data, setData] = useState(null)

  useEffect(() => {
    async function fetchData() {
      await fetch('/candidates.json')
      .then(res => res.json())
      .then(res => {setData(res)})
    }

    fetchData()
  }, [])

  if(!data) { return(null) }

  // Sub to backend websocket
  consumer.subscriptions.create("CandidatesChannel", {
    received(updatedData) {
      let oldData = data
      setData({
        status: oldData.status,
        candidates: JSON.parse(updatedData.updatedCandidates)
      })
    }
  });

  const sendUpdateToBackEnd = (candidateToUpdate) => {
    fetch(`candidates/${candidateToUpdate.id}`, {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(candidateToUpdate)
    })
  }

  const findNewRank = (source, destination) => {
    let destinationCandidates = data.candidates.filter((c) => { return(c.status === destination.droppableId) })
    let candidateBefore = destinationCandidates[destination.index - 1]
    let candidateAfter  = destinationCandidates[destination.index]

    // by default let respect the true index
    let newRank = destination.index
    let changingColumn = destination.droppableId !== source.droppableId

    if(candidateBefore) { newRank = candidateBefore.rank + 1 }
    if(candidateAfter && !candidateBefore)  { newRank = candidateAfter.rank - 1 }

    // compensation for leaving space in ranking through column
    if(changingColumn && destination.index > source.index) { newRank = newRank - 1 }

    return newRank
  }

  const onDragEnd = result => {
    const { destination, source, draggableId } = result

    if(!destination) { return; }

    const cardDidntMoove = destination.droppableId === source.droppableId && destination.index === source.index
    if(cardDidntMoove)
     { return; }

    let candidateToUpdate = {
      id: draggableId,
      status: destination.droppableId,
      rank: findNewRank(result.source, result.destination)
    }

    sendUpdateToBackEnd(candidateToUpdate)

    setData({status: data.status, candidates: []})
  }

  const statusValues = Object.values(data.status)
  const statusTrad   = Object.keys(data.status)

  return(
    <DragDropContext onDragEnd={onDragEnd}>
      <div className='candidates-react-component'>
        {
          statusValues.map((status, index) => {
            return(
              <CardBoard
                title={statusTrad[index]}
                statusValue={status}
                candidates={data.candidates.filter((candidate) => { return(candidate.status === status) })}
                key={index}
              />
            )
          })
        }
      </div>
    </DragDropContext>
  )
}

CandidatesIndex.propTypes = { name: PropTypes.string }

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <CandidatesIndex name="React" />,
    document.body.appendChild(document.createElement('div')),
  )
})
